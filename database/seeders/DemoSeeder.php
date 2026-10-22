<?php

namespace Database\Seeders;

use App\Models\AnalysisPeriod;
use App\Models\Company;
use App\Models\Role;
use App\Models\User;
use App\Models\UserContext;
use App\Services\Import\BscImporter;
use App\Services\Import\BscTemplate;
use App\Support\DhastramContext;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use RuntimeException;

/**
 * Perusahaan contoh untuk demo & pelatihan (is_demo = true, hapus dengan `php artisan rucibsc:hapus-contoh`).
 *
 * - DFI: PT Diamond Food Indonesia Tbk — realisasi 2025 dari Laporan Tahunan 2025; target masih angka contoh.
 * - NLP & KSB: perusahaan fiktif dengan data bulanan Jan–Sep 2026.
 *
 * Semua data dimasukkan lewat BscImporter (jalur yang sama dengan upload Excel), sehingga seeder ini
 * sekaligus menguji format workbook.
 */
class DemoSeeder extends Seeder
{
    public const PASSWORD = 'Contoh-2026!';

    public const ADMIN_EMAIL = 'admin@rucibsc.local';

    public function run(): void
    {
        $admin = User::updateOrCreate(['email' => self::ADMIN_EMAIL], [
            'name' => 'Super Admin Rucisoft', 'job_title' => 'Konsultan Rucisoft', 'department' => 'Rucisoft', 'is_active' => true,
            'password' => Hash::make(env('RUCI_ADMIN_PASSWORD', 'Ruci@BSC2026')), 'must_change_password' => false, 'email_verified_at' => now(),
        ]);
        $this->assign($admin, 'super-admin', null);

        foreach ([$this->diamondFood(), $this->logistik(), $this->klinik()] as $def) {
            $company = Company::updateOrCreate(['code' => $def['company']['code']], $def['company'] + ['is_active' => true, 'is_demo' => true]);
            foreach ($def['periods'] as $p) {
                AnalysisPeriod::updateOrCreate(['company_id' => $company->id, 'code' => (string) $p['year']], $p + [
                    'name' => 'Tahun '.$p['year'], 'start_date' => $p['year'].'-01-01', 'end_date' => $p['year'].'-12-31',
                ]);
            }
            $period = AnalysisPeriod::where('company_id', $company->id)->where('is_active', true)->firstOrFail();
            foreach ($def['users'] as [$name, $email, $title, $dept, $roles]) {
                $user = User::updateOrCreate(['email' => $email], [
                    'name' => $name, 'job_title' => $title, 'department' => $dept, 'is_active' => true,
                    'password' => Hash::make(self::PASSWORD), 'must_change_password' => false, 'email_verified_at' => now(),
                ]);
                $user->companies()->syncWithoutDetaching([$company->id]);
                foreach ($roles as $slug) {
                    $this->assign($user, $slug, $company->id);
                }
                UserContext::updateOrCreate(['user_id' => $user->id], ['company_id' => $company->id, 'analysis_period_id' => $period->id]);
            }
            foreach ($def['imports'] as $i => [$fileName, $sheets, $approve]) {
                $this->import($company, $period, $admin, $fileName, $sheets, $approve);
            }
        }
        UserContext::updateOrCreate(['user_id' => $admin->id], [
            'company_id' => Company::where('code', 'DFI')->value('id'),
            'analysis_period_id' => AnalysisPeriod::whereHas('company', fn ($q) => $q->where('code', 'DFI'))->where('is_active', true)->value('id'),
        ]);
        app(DhastramContext::class)->clear();
    }

    protected function assign(User $user, string $slug, ?int $companyId): void
    {
        $role = Role::where('slug', $slug)->firstOrFail();
        if (! $user->roles()->where('roles.id', $role->id)->wherePivot('company_id', $companyId)->exists()) {
            $user->roles()->attach($role->id, ['company_id' => $companyId]);
        }
    }

    protected function import(Company $company, AnalysisPeriod $period, User $admin, string $fileName, array $sheets, bool $approve): void
    {
        $file = storage_path('app/private/exports/seed-'.$company->code.'-'.uniqid().'.xlsx');
        app(BscTemplate::class)->withRows($file, $sheets);
        try {
            $result = app(BscImporter::class)->run($file, $period, $admin, ['approve_actuals' => $approve, 'file_name' => $fileName]);
        } finally {
            @unlink($file);
        }
        if ($result->errorCount() > 0) {
            throw new RuntimeException('Data contoh '.$company->code.' gagal diimport: '.json_encode($result->issues, JSON_UNESCAPED_UNICODE));
        }
    }

    // ------------------------------------------------------------------ PT Diamond Food Indonesia Tbk

    protected function diamondFood(): array
    {
        $note = 'Target adalah angka contoh untuk demo; realisasi dari Laporan Tahunan 2025.';
        $src = 'Laporan Tahunan 2025 PT Diamond Food Indonesia Tbk';
        // kode, sasaran, nama, satuan, polaritas, desimal, baseline 2024, target (contoh), realisasi 2025, keuangan, sumber
        $kpis = [
            ['F1.1', 'F1', 'Pendapatan', 'Rp juta', 'naik', 0, 9811549, 10800000, 11098665, 'ya', $src.', Ikhtisar Keuangan'],
            ['F2.1', 'F2', 'Laba tahun berjalan', 'Rp juta', 'naik', 0, 363732, 400000, 435170, 'ya', $src.', Ikhtisar Keuangan'],
            ['F2.2', 'F2', 'Margin laba bruto (Laba Bruto/Pendapatan)', '%', 'naik', 2, 21.17, 21.00, 20.26, 'ya', $src.', Rasio Usaha'],
            ['F2.3', 'F2', 'ROE (Laba/Total Ekuitas)', '%', 'naik', 2, 5.86, 6.50, 6.62, 'ya', $src.', Rasio Usaha'],
            ['F2.4', 'F2', 'ROA (Laba/Total Aset)', '%', 'naik', 2, 4.88, 5.00, 5.23, 'ya', $src.', Rasio Usaha'],
            ['F3.1', 'F3', 'Rasio liabilitas terhadap ekuitas', 'rasio', 'turun', 2, 0.20, 0.25, 0.26, 'ya', $src.', Rasio Keuangan'],
            ['C1.1', 'C1', 'Jumlah titik distribusi', 'unit', 'naik', 0, null, 25, 24, 'tidak', $src.', Wilayah Operasional'],
            ['P1.1', 'P1', 'Perputaran persediaan', 'rasio', 'naik', 2, 3.60, 3.80, 3.75, 'tidak', $src.', Rasio Aktivitas'],
            ['P1.2', 'P1', 'Perputaran piutang', 'rasio', 'naik', 2, 8.57, 9.00, 9.01, 'tidak', $src.', Rasio Aktivitas'],
            ['P1.3', 'P1', 'Perputaran aset', 'rasio', 'naik', 2, 1.34, 1.40, 1.41, 'tidak', $src.', Rasio Aktivitas'],
            ['L1.1', 'L1', 'Pendapatan per karyawan', 'Rp juta', 'naik', 1, 1292.3, 1400, 1445.3, 'tidak', 'Dihitung: pendapatan ÷ jumlah karyawan (7.679 orang, 2024: 7.592)'],
        ];
        $owner = ['F' => 'dfi.keuangan@contoh.local', 'C' => 'dfi.komersial@contoh.local', 'P' => 'dfi.komersial@contoh.local', 'L' => 'dfi.sdm@contoh.local'];
        $empty12 = array_fill(0, 11, null);

        return [
            'company' => [
                'code' => 'DFI', 'name' => 'PT Diamond Food Indonesia Tbk', 'legal_name' => 'PT Diamond Food Indonesia Tbk',
                'industry' => 'Makanan & minuman (manufaktur & distribusi)', 'address' => 'TCC Batavia Tower One Lt. 15, Jl. KH Mas Mansyur Kav. 126',
                'city' => 'Jakarta Pusat', 'phone' => '+62 21 2864 9888', 'website' => 'https://www.diamondfoodindonesia.com',
                'description' => 'Perusahaan contoh dari Laporan Tahunan 2025 (kode saham DMND). '.$note,
            ],
            'periods' => [['code' => '2025', 'year' => 2025, 'status' => 'berjalan', 'is_active' => true, 'notes' => 'Realisasi tahunan 2025 dari laporan tahunan. '.$note]],
            'users' => [
                ['Admin Diamond (contoh)', 'dfi.admin@contoh.local', 'Admin Sistem', 'Corporate Strategy', ['company-admin']],
                ['Direktur Utama (contoh)', 'dfi.direktur@contoh.local', 'Direktur Utama', 'Direksi', ['pimpinan']],
                ['Kepala Keuangan (contoh)', 'dfi.keuangan@contoh.local', 'Chief Financial Officer', 'Keuangan', ['keuangan']],
                ['Kepala Komersial (contoh)', 'dfi.komersial@contoh.local', 'Commercial Director', 'Komersial', ['kepala-unit']],
                ['Kepala SDM (contoh)', 'dfi.sdm@contoh.local', 'Human Capital Director', 'SDM', ['kepala-unit']],
            ],
            'imports' => [['diamond-food-2025.xlsx', [
                'Jati Diri' => [
                    ['visi', 'Menjadi platform makanan dan minuman yang paling unggul di Indonesia.'],
                    ['misi', "Menyediakan solusi yang saling menguntungkan bagi pelanggan dan prinsipal kami.\nMengembangkan budaya kinerja tinggi dan inovasi di dalam perusahaan.\nMemperkuat masyarakat dengan cara memfasilitasi kegembiraan bagi semua pelanggan dan keluarga mereka.\nMenerapkan pendekatan yang berkelanjutan pada semua kegiatan usaha."],
                    ['tagline', 'Evolving Greatness'],
                ],
                'Nilai Inti' => [
                    ['Keberlangsungan', 'Longevity', 'Membangun masa depan secara konsisten untuk keberlangsungan nilai organisasi bagi pemangku kepentingan.', null],
                    ['Integritas', 'Integrity', 'Berkomitmen untuk selalu jujur dan bertanggung jawab.', null],
                    ['Pembelajaran dan Inovasi', 'Learning & Innovation', 'Berusaha untuk terus berinovasi dan mencoba hal-hal baru.', null],
                    ['Keluarga', 'Family', 'Menjunjung kejujuran, loyalitas, kepedulian antar karyawan, dan lingkungan kerja yang solid.', null],
                    ['Kewaspadaan dalam Penggunaan Dana', 'Frugality', 'Pengeluaran yang hati-hati, investasi strategis, dan pemanfaatan aset maksimal.', null],
                    ['Pemberdayaan', 'Empowerment', 'Memberdayakan karyawan sebagai komponen penting pertumbuhan berkelanjutan.', null],
                ],
                'Tema' => [
                    ['T1', 'Pertumbuhan yang menguntungkan', 'Contoh tema strategis', '#A8432A'],
                    ['T2', 'Distribusi & operasi unggul', 'Contoh tema strategis', '#34506E'],
                    ['T3', 'Budaya kinerja tinggi', 'Contoh tema strategis', '#4F6B3A'],
                ],
                'Sasaran' => [
                    ['F1', 'Keuangan', 'Meningkatkan pendapatan', 'T1', null, 2, 'dfi.keuangan@contoh.local'],
                    ['F2', 'Keuangan', 'Meningkatkan profitabilitas', 'T1', null, 2, 'dfi.keuangan@contoh.local'],
                    ['F3', 'Keuangan', 'Menjaga struktur modal yang sehat', 'T1', null, 1, 'dfi.keuangan@contoh.local'],
                    ['C1', 'Kepuasan Pelanggan', 'Memperluas jangkauan distribusi ke pelanggan', 'T2', null, 1, 'dfi.komersial@contoh.local'],
                    ['P1', 'Proses Internal', 'Meningkatkan efisiensi modal kerja & aset', 'T2', null, 1, 'dfi.komersial@contoh.local'],
                    ['L1', 'SDM & Pembelajaran', 'Meningkatkan produktivitas karyawan', 'T3', null, 1, 'dfi.sdm@contoh.local'],
                ],
                'Relasi Sasaran' => [['L1', 'P1', 2, null], ['P1', 'C1', 2, null], ['C1', 'F1', 3, null], ['F1', 'F2', 3, null], ['P1', 'F2', 2, null], ['F2', 'F3', 1, null]],
                'KPI' => array_map(fn ($k) => [$k[0], $k[1], $k[2], $k[3], $k[4], 'tahunan', 'terakhir', 1, $k[6], $k[7], $k[5], $k[9],
                    in_array($k[0], ['F1.1', 'F2.1'], true) ? 'ya' : 'tidak', $k[10], $owner[$k[0][0]], 'Baseline = realisasi 2024.'], $kpis),
                'Target' => array_map(fn ($k) => array_merge([$k[0]], $empty12, [$k[7], 'Target contoh']), $kpis),
                'Realisasi' => array_map(fn ($k) => array_merge([$k[0]], $empty12, [$k[8], null, $k[10]]), $kpis),
                'Inisiatif' => [
                    ['DFI-I1', 'Pembukaan titik distribusi baru', 'C1, F1', 'T2', 'dfi.komersial@contoh.local', '2025-01-01', '2025-12-31', 'selesai', 4, 4, 3, 4, null, 'Contoh inisiatif berdasarkan laporan tahunan (titik distribusi baru, gudang).', 'Jangkauan distribusi bertambah'],
                    ['DFI-I2', 'Product Knowledge Training & Diamond Apex Program', 'L1', 'T3', 'dfi.sdm@contoh.local', '2025-01-01', '2025-12-31', 'selesai', 3, 3, 2, 2, null, 'Program pengembangan SDM yang disebut di laporan tahunan.', 'Produktivitas karyawan naik'],
                ],
            ], true]],
        ];
    }

    // ------------------------------------------------------------------ perusahaan fiktif

    /** Deret bulanan deterministik: nilai dasar × (1 + tren × bulan) ± variasi. */
    protected function series(float $base, float $trend, float $noise, int $months, int $decimals, int $seed): array
    {
        mt_srand($seed);
        $out = [];
        for ($m = 1; $m <= $months; $m++) {
            $out[] = round($base * (1 + $trend * $m) * (1 + (mt_rand(-1000, 1000) / 1000) * $noise), $decimals);
        }

        return $out;
    }

    /** @param array<int,array{0:string,1:string,2:string,3:string,4:string,5:string,6:int,7:float,8:float,9:float,10:float,11:string}> $kpis */
    protected function fictive(array $kpis, string $prefixEmail): array
    {
        $kpiRows = $targets = $draft = $approved = [];
        foreach ($kpis as $n => [$code, $obj, $name, $unit, $dir, $agg, $dec, $target, $actual, $trend, $noise, $owner]) {
            $kpiRows[] = [$code, $obj, $name, $unit, $dir, 'bulanan', $agg, 1, null, null, $dec, $obj[0] === 'K' ? 'ya' : 'tidak', 'tidak', null, $prefixEmail.$owner.'@contoh.local', null];
            $targets[] = array_merge([$code], $this->series($target, $trend, 0, 12, $dec, 1), [null]);
            $values = $this->series($actual, $trend, $noise, 9, $dec, 100 + $n);
            $approved[] = array_merge([$code], array_slice($values, 0, 8), array_fill(0, 4, null), [null, 'Sistem operasional (data fiktif)']);
            $draft[] = array_merge([$code], array_fill(0, 8, null), [$values[8]], array_fill(0, 3, null), ['Menunggu verifikasi', 'Sistem operasional (data fiktif)']);
        }

        return [$kpiRows, $targets, $approved, $draft];
    }

    protected function logistik(): array
    {
        // kode, sasaran, nama, satuan, polaritas, agregasi, desimal, target dasar, realisasi dasar, tren/bulan, variasi, pemilik
        [$kpis, $targets, $approved, $draft] = $this->fictive([
            ['K1.1', 'K1', 'Pendapatan jasa logistik', 'Rp juta', 'naik', 'jumlah', 0, 4000, 3900, 0.01, 0.06, 'keuangan'],
            ['K2.1', 'K2', 'Rasio biaya operasional terhadap pendapatan', '%', 'turun', 'rata-rata', 1, 82, 84, 0, 0.03, 'keuangan'],
            ['C1.1', 'C1', 'Pengiriman tepat waktu (OTD)', '%', 'naik', 'rata-rata', 1, 95, 93, 0.001, 0.02, 'operasi'],
            ['C1.2', 'C1', 'Keluhan pelanggan', 'kasus', 'turun', 'jumlah', 0, 20, 23, -0.01, 0.2, 'operasi'],
            ['P1.1', 'P1', 'Utilisasi armada', '%', 'naik', 'rata-rata', 1, 85, 81, 0.002, 0.04, 'operasi'],
            ['P1.2', 'P1', 'Barang rusak dalam pengiriman', '%', 'turun', 'rata-rata', 2, 0.5, 0.55, 0, 0.2, 'operasi'],
            ['L1.1', 'L1', 'Jam pelatihan per karyawan', 'jam', 'naik', 'jumlah', 1, 2, 1.8, 0, 0.25, 'sdm'],
            ['L1.2', 'L1', 'Turnover karyawan', '%', 'turun', 'rata-rata', 2, 1.5, 1.6, 0, 0.2, 'sdm'],
        ], 'nlp.');

        return [
            'company' => ['code' => 'NLP', 'name' => 'PT Nusantara Logistik Prima (fiktif)', 'industry' => 'Logistik & ekspedisi', 'city' => 'Surabaya',
                'description' => 'Perusahaan fiktif untuk demo multi-perusahaan. Semua angka rekaan.'],
            'periods' => [
                ['code' => '2026', 'year' => 2026, 'status' => 'berjalan', 'is_active' => true, 'notes' => 'Realisasi Jan–Agu disetujui, Sep masih draf (data fiktif).'],
                ['code' => '2027', 'year' => 2027, 'status' => 'perencanaan', 'is_active' => false, 'notes' => 'Disiapkan untuk perencanaan.'],
            ],
            'users' => [
                ['Admin NLP (fiktif)', 'nlp.admin@contoh.local', 'Admin Sistem', 'IT', ['company-admin']],
                ['Direktur NLP (fiktif)', 'nlp.direktur@contoh.local', 'Direktur', 'Direksi', ['pimpinan']],
                ['Manajer Keuangan NLP (fiktif)', 'nlp.keuangan@contoh.local', 'Manajer Keuangan', 'Keuangan', ['keuangan']],
                ['Manajer Operasi NLP (fiktif)', 'nlp.operasi@contoh.local', 'Manajer Operasi', 'Operasi', ['kepala-unit']],
                ['Manajer SDM NLP (fiktif)', 'nlp.sdm@contoh.local', 'Manajer SDM', 'SDM', ['kepala-unit']],
            ],
            'imports' => [
                ['nlp-struktur-dan-realisasi-jan-agu-2026.xlsx', [
                    'Jati Diri' => [['visi', 'Menjadi mitra logistik paling andal di Indonesia Timur.'], ['misi', 'Mengirim tepat waktu, aman, dan efisien bagi setiap pelanggan.']],
                    'Nilai Inti' => [['Andal', null, 'Menepati janji pengiriman.', null], ['Aman', null, 'Keselamatan orang dan barang nomor satu.', null]],
                    'Sasaran' => [
                        ['K1', 'Keuangan', 'Menumbuhkan pendapatan', null, null, 2, 'nlp.keuangan@contoh.local'],
                        ['K2', 'Keuangan', 'Mengendalikan biaya operasional', null, null, 1, 'nlp.keuangan@contoh.local'],
                        ['C1', 'Kepuasan Pelanggan', 'Layanan pengiriman yang andal', null, null, 1, 'nlp.operasi@contoh.local'],
                        ['P1', 'Proses Internal', 'Operasi armada yang efisien & aman', null, null, 1, 'nlp.operasi@contoh.local'],
                        ['L1', 'SDM & Pembelajaran', 'SDM yang kompeten dan bertahan', null, null, 1, 'nlp.sdm@contoh.local'],
                    ],
                    'Relasi Sasaran' => [['L1', 'P1', 2, null], ['P1', 'C1', 3, null], ['C1', 'K1', 3, null], ['P1', 'K2', 2, null]],
                    'KPI' => $kpis, 'Target' => $targets, 'Realisasi' => $approved,
                    'Inisiatif' => [
                        ['NLP-I1', 'Sistem pelacakan armada real-time', 'C1, P1', null, 'nlp.operasi@contoh.local', '2026-02-01', '2026-11-30', 'berjalan', 5, 4, 3, 4, 850000000, null, 'OTD ≥ 95%'],
                        ['NLP-I2', 'Akademi pengemudi', 'L1', null, 'nlp.sdm@contoh.local', '2026-03-01', '2026-12-31', 'berjalan', 3, 3, 2, 2, 150000000, null, 'Turnover < 1,5%'],
                    ],
                ], true],
                ['nlp-realisasi-sep-2026.xlsx', ['Realisasi' => $draft], false],
            ],
        ];
    }

    protected function klinik(): array
    {
        [$kpis, $targets, $approved, $draft] = $this->fictive([
            ['K1.1', 'K1', 'Pendapatan layanan', 'Rp juta', 'naik', 'jumlah', 0, 1500, 1520, 0.008, 0.05, 'keuangan'],
            ['K1.2', 'K1', 'Margin operasi', '%', 'naik', 'rata-rata', 1, 18, 16.5, 0, 0.08, 'keuangan'],
            ['C1.1', 'C1', 'Indeks kepuasan pasien', 'indeks', 'naik', 'rata-rata', 2, 4.5, 4.4, 0, 0.02, 'layanan'],
            ['C1.2', 'C1', 'Pasien dilayani < 30 menit', '%', 'naik', 'rata-rata', 1, 90, 86, 0.003, 0.03, 'layanan'],
            ['P1.1', 'P1', 'Kepatuhan SOP klinis', '%', 'naik', 'rata-rata', 1, 98, 97, 0, 0.01, 'layanan'],
            ['P1.2', 'P1', 'Insiden keselamatan pasien', 'kasus', 'turun', 'jumlah', 0, 1, 1, 0, 0.5, 'layanan'],
            ['L1.1', 'L1', 'Tenaga medis bersertifikat kompetensi', '%', 'naik', 'terakhir', 1, 95, 92, 0.002, 0.01, 'sdm'],
        ], 'ksb.');

        return [
            'company' => ['code' => 'KSB', 'name' => 'Klinik Sehat Bersama (fiktif)', 'industry' => 'Layanan kesehatan', 'city' => 'Bandung',
                'description' => 'Perusahaan fiktif untuk demo multi-perusahaan. Semua angka rekaan.'],
            'periods' => [['code' => '2026', 'year' => 2026, 'status' => 'berjalan', 'is_active' => true, 'notes' => 'Data fiktif.']],
            'users' => [
                ['Admin KSB (fiktif)', 'ksb.admin@contoh.local', 'Admin Sistem', 'Manajemen', ['company-admin']],
                ['Direktur KSB (fiktif)', 'ksb.direktur@contoh.local', 'Direktur Klinik', 'Direksi', ['pimpinan']],
                ['Keuangan KSB (fiktif)', 'ksb.keuangan@contoh.local', 'Kepala Keuangan', 'Keuangan', ['keuangan']],
                ['Kepala Layanan KSB (fiktif)', 'ksb.layanan@contoh.local', 'Kepala Pelayanan Medis', 'Pelayanan', ['kepala-unit']],
                ['Kepala SDM KSB (fiktif)', 'ksb.sdm@contoh.local', 'Kepala SDM', 'SDM', ['kepala-unit']],
            ],
            'imports' => [
                ['ksb-2026.xlsx', [
                    'Jati Diri' => [['visi', 'Klinik keluarga pilihan utama di Bandung Raya.'], ['misi', 'Layanan cepat, ramah, dan aman untuk setiap pasien.']],
                    'Sasaran' => [
                        ['K1', 'Keuangan', 'Pertumbuhan pendapatan yang sehat', null, null, 1, 'ksb.keuangan@contoh.local'],
                        ['C1', 'Kepuasan Pelanggan', 'Pasien puas dan setia', null, null, 1, 'ksb.layanan@contoh.local'],
                        ['P1', 'Proses Internal', 'Layanan klinis yang aman & sesuai standar', null, null, 1, 'ksb.layanan@contoh.local'],
                        ['L1', 'SDM & Pembelajaran', 'Tenaga medis kompeten', null, null, 1, 'ksb.sdm@contoh.local'],
                    ],
                    'Relasi Sasaran' => [['L1', 'P1', 3, null], ['P1', 'C1', 3, null], ['C1', 'K1', 2, null]],
                    'KPI' => $kpis, 'Target' => $targets, 'Realisasi' => $approved,
                    'Inisiatif' => [
                        ['KSB-I1', 'Pendaftaran online & antrean digital', 'C1', null, 'ksb.layanan@contoh.local', '2026-01-15', '2026-09-30', 'berjalan', 4, 5, 2, 3, 120000000, null, 'Waktu tunggu < 30 menit'],
                    ],
                ], true],
                ['ksb-realisasi-sep-2026.xlsx', ['Realisasi' => $draft], false],
            ],
        ];
    }
}
