<?php

namespace Database\Seeders\Gpch;

use App\Models\Institutionalization;
use App\Models\MaturityAnswer;
use App\Models\MaturityAssessment;
use App\Models\MaturityQuestion;
use App\Models\StrategicDependency;
use App\Services\MaturityScoringService;

class ContinuitySeeder
{
    public function seed(array $u, array $perf): void
    {
        $ini = $perf['initiatives'];
        $o = $perf['objectives'];

        // Penilaian kematangan awal (baseline) — skor PROYEKSI berdasarkan dokumen, wajib dinilai ulang bersama HOD & Timwas
        $a = MaturityAssessment::create(['title' => 'Penilaian Awal Kematangan Manajemen Strategi 2026 (baseline)', 'assessment_date' => '2026-10-14',
            'assessor_id' => $u['koordinator']->id, 'status' => 'final',
            'notes' => 'Baseline saat migrasi ke Arah GPCH, disusun dari assessment Des 2024, MoM 2026 dan GM Weekly Report. Ulangi penilaian bersama GM, HOD & Timwas pada Nov–Des 2026.']);
        $scores = [
            'Pemindaian lingkungan' => 3, 'Analisis pesaing' => 3, 'Pemahaman pelanggan' => 2, 'Isu strategis' => 2, 'Regulasi & pemangku kepentingan' => 2,
            'Visi & misi' => 2, 'Nilai inti' => 2, 'Kapabilitas' => 2, 'Proposisi nilai' => 2, 'Keselarasan budaya' => 2,
            'Sasaran strategis' => 2, 'KPI & target' => 3, 'Realisasi tepat waktu' => 2, 'Tinjauan kinerja' => 3, 'Pelaporan keuangan' => 2,
            'Portofolio inisiatif' => 2, 'Pemantauan progres' => 2, 'Anggaran inisiatif' => 1, 'Temuan & koreksi' => 2, 'Penutupan temuan' => 1,
            'Pelembagaan ritme' => 3, 'Kebijakan & SOP' => 2, 'Sistem pendukung' => 2, 'Pembelajaran organisasi' => 1, 'Ketergantungan & risiko' => 1,
        ];
        foreach (MaturityQuestion::orderBy('sort')->get() as $q) {
            MaturityAnswer::create(['maturity_assessment_id' => $a->id, 'maturity_question_id' => $q->id, 'score' => $scores[$q->dimension] ?? 2,
                'evidence' => match ($q->dimension) {
                    'Analisis pesaing' => 'Benchmark kompetitor mingguan di GM Weekly Report.',
                    'Tinjauan kinerja' => 'Weekly report GM tiap Senin & rapat manajemen.',
                    'Pelaporan keuangan' => 'Neraca belum rutin (assessment 2024); PnL & cash flow mulai rutin 2026.',
                    'Pelembagaan ritme' => 'Weekly report, rapat manajemen, rapat Timwas berjalan.',
                    'Penutupan temuan' => 'Belum ada mekanisme formal penutupan tindak lanjut MoM.',
                    default => null,
                }]);
        }
        app(MaturityScoringService::class)->recalculate($a);

        foreach ([
            ['Dana revitalisasi fasilitas', 'internal', 'facility', 'P3', 'Arus kas operasional & persetujuan pemilik', 'Revitalisasi dapur, ruang rapat dan lounge bergantung pada surplus kas yang saat ini sangat tipis.', 'ca', 'tinggi', 'Prioritaskan berdasarkan dampak pendapatan; skema co-branding AV (smartboard) & vendor pembiayaan.'],
            ['Dukungan vendor VHP', 'eksternal', 'vhp', 'P1', 'VHP (vendor PMS cloud)', 'Menu dashboard, notifikasi approval PR & artikel casual menunggu tindak lanjut vendor (Ticket #181ADD).', 'edp', 'sedang', 'Daftar permintaan bertimeline; eskalasi bulanan ke account manager VHP.'],
            ['Tanda tangan CEO untuk konversi CNG', 'internal', 'energy', 'F3', 'CEO', 'Mutasi LPG ke CNG sudah disetujui lisan tetapi menunggu tanda tangan.', 'ce', 'sedang', 'GM menjadwalkan penandatanganan pada rapat Oktober.'],
            ['Vendor panel lift (Elpa Global Techno)', 'eksternal', 'facility', 'P3', 'PT Elpa Global Techno', 'Penyelesaian panel lift 1 dan uji laik operasi.', 'ce', 'sedang', 'Pantau timeline harian; siapkan lift 2 sebagai cadangan.'],
            ['Kalender event pemerintah daerah', 'eksternal', 'recovery', 'C3', 'Dispora, Disbudpar, KONI Jabar', 'Event Piala Gubernur & PORPROV bergantung jadwal & anggaran instansi.', 'sales', 'sedang', 'Diversifikasi pipeline ke korporasi & sosial.'],
            ['Keputusan pemilik atas restrukturisasi utang CEO', 'internal', 'cash', 'F2', 'Pemilik & CEO', 'Tenor, bunga, subordinasi atau konversi utang Rp30,91 M.', 'ca', 'tinggi', 'Siapkan 3 opsi beserta dampak arus kas.'],
            ['Rekrutmen Chief Engineer & Executive Housekeeper', 'internal', 'people', 'L3', 'HRD & GM', 'Posisi CE & EHK masih Plt.; pemeliharaan preventif & standar kebersihan bergantung pada kepemimpinan departemen.', 'hrm', 'sedang', 'Finalisasi kandidat CE; tanda tangani LOI EHK.'],
        ] as [$title, $type, $iniKey, $objKey, $dep, $desc, $owner, $risk, $mit]) {
            StrategicDependency::create(['title' => $title, 'dependency_type' => $type, 'strategic_initiative_id' => $ini[$iniKey]->id, 'strategic_objective_id' => $o[$objKey]->id,
                'depends_on' => $dep, 'description' => $desc, 'owner_id' => $u[$owner]->id, 'risk_level' => $risk, 'mitigation' => $mit, 'status' => 'aktif']);
        }

        foreach ([
            ['GM Weekly Report setiap Senin', 'rapat', 'Laporan mingguan GM: revenue MTD vs budget, kompetitor, aktivitas & rencana tiap departemen, guest comments, energi, SDM.', 'Mingguan (Senin)', 'gm', 'melembaga', 'Arsip weekly report 2026.', '2026-01-05', '2026-12-28'],
            ['Rapat manajemen bulanan (tanggal 10)', 'rapat', 'Tinjau sasaran merah/kuning, tutup temuan selesai, ekspor laporan Arah GPCH.', 'Bulanan', 'gm', 'berjalan', 'Notulen rapat manajemen.', '2026-01-10', '2026-11-10'],
            ['Rapat Tim Pengawas', 'rapat', 'Pengawasan pemilik; catatan pengawasan & temuan Timwas dicatat di Arah GPCH.', 'Bulanan / kuartalan', 'wilfred', 'berjalan', 'Notulen GBK–GPCH 3 Jun 2026.', '2026-06-03', '2026-11-15'],
            ['Siklus realisasi KPI di Arah GPCH', 'sistem', 'Input tgl 5 → verifikasi keuangan tgl 7 → persetujuan GM tgl 8 → rapat tgl 10.', 'Bulanan', 'koordinator', 'rencana', null, '2026-11-01', '2026-12-10'],
            ['Tiga laporan keuangan wajib (PnL, arus kas, neraca)', 'kebijakan', 'Diterbitkan paling lambat 10 hari setelah tutup bulan.', 'Bulanan', 'ca', 'berjalan', 'Laporan keuangan Jun–Sep 2026.', '2026-06-01', '2026-11-10'],
            ['Daily pipeline report Sales', 'sop', 'Inquiry, quotation, follow-up, tentative, confirmed, revenue potential.', 'Harian', 'sales', 'berjalan', 'Sejak 23 Sep 2026.', '2026-09-23', '2026-12-31'],
            ['Tindak lanjut MoM dengan timeline & PIC', 'kebijakan', 'Setiap usulan di MoM ditindaklanjuti pada aktivitas minggu berikutnya.', 'Mingguan', 'koordinator', 'berjalan', null, '2026-09-23', '2026-12-31'],
            ['Refresh training per departemen', 'pelatihan', 'Jadwal berkala oleh Head of Department.', 'Bulanan', 'hrm', 'berjalan', 'Training Sep 2026: F&B, engineering, FO.', '2026-05-01', '2026-12-31'],
            ['PNP VHP untuk HOD', 'sistem', 'Panduan penggunaan VHP agar HOD terbiasa membuka sistem.', 'Sekali + penyegaran', 'edp', 'rencana', null, null, '2026-11-15'],
            ['Budaya "bersepakat dalam tindakan"', 'budaya', 'Nilai Disiplin & Sabilulungan: keputusan rapat dijalankan bersama; teguran sesuai peraturan.', 'Berkelanjutan', 'gm', 'rencana', null, null, '2026-12-31'],
        ] as [$title, $type, $desc, $freq, $owner, $status, $evidence, $start, $next]) {
            Institutionalization::create(['title' => $title, 'mechanism_type' => $type, 'description' => $desc, 'frequency' => $freq, 'owner_id' => $u[$owner]->id,
                'status' => $status, 'evidence' => $evidence, 'started_at' => $start, 'next_review_date' => $next]);
        }
    }
}
