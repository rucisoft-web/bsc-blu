<?php

namespace Database\Seeders\Gpch;

use App\Models\Kpi;
use App\Models\KpiActual;
use App\Models\KpiTarget;
use App\Models\ObjectiveRelation;
use App\Models\PerformanceReview;
use App\Models\ReviewNote;
use App\Models\StrategicChoice;
use App\Models\StrategicObjective;
use App\Models\StrategicTheme;

/**
 * Tema, pilihan, 13 sasaran, 28 KPI dengan target 12 bulan & realisasi Jan–Sep 2026, serta tinjauan kinerja.
 * Angka anggaran Sep 2026 & realisasi MTD diambil dari GM Weekly Report 21–27 Sep 2026;
 * likuiditas Juni dari Analisis Singkat Keuangan; selebihnya PROYEKSI (ditandai is_projection & catatan).
 */
class PerformanceSeeder
{
    public const DAYS = [1 => 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    /** Anggaran 2026 (okupansi %, ADR Rp ribu, banquet Rp jt, outlet Rp jt, lain-lain Rp jt) */
    public const BUDGET = [
        'occ' => [1 => 50, 47, 45, 55, 57, 62, 63, 56, 52.54, 55, 57, 66],
        'adr' => [1 => 395, 392, 390, 398, 400, 405, 405, 400, 398.86, 400, 402, 420],
        'banquet' => [1 => 1150, 1050, 820, 1250, 1300, 1320, 1350, 1250, 1308.87, 1300, 1350, 1500],
        'outlet' => [1 => 145, 140, 160, 148, 150, 155, 158, 150, 152.56, 150, 150, 175],
        'other' => [1 => 92, 88, 85, 93, 95, 98, 100, 96, 93.96, 95, 96, 105],
        'breakfast_per_rn' => 0.0483,
    ];

    /** Realisasi Jan–Sep 2026 */
    public const ACTUAL = [
        'occ' => [1 => 46.2, 41.5, 38.7, 51.8, 54.6, 61.3, 59.4, 53.3, 49.0],
        'adr' => [1 => 341, 328, 336, 349, 352, 366, 360, 345.13, 334.55],
        'banquet' => [1 => 395, 340, 260, 560, 655, 603, 720, 700, 480],
        'outlet' => [1 => 52, 45, 70, 55, 58, 60, 57, 50, 44],
        'other' => [1 => 84, 79, 72, 88, 91, 92, 95, 90, 81],
        'breakfast_per_rn' => 0.076,
    ];

    public function seed(array $u): array
    {
        // ---------------- Tema strategis
        $themes = [];
        foreach ([
            'rev' => ['Pemulihan Pendapatan', 'Revenue recovery kamar & banquet: tactical pricing, diversifikasi segmen, kemitraan TA/EO.', '#A8432A'],
            'exp' => ['Hotel Serbaguna Berbasis Pengalaman Pasundan', 'Storytelling Sunda, revitalisasi fasilitas prioritas, reputasi digital.', '#B8862B'],
            'fin' => ['Disiplin Keuangan & Sistem', 'Tiga laporan wajib, arus kas mingguan, food cost, VHP sebagai alat operasional.', '#34506E'],
            'sdm' => ['SDM Multitasking yang Kompeten & Sejahtera', 'Gaji & service tepat waktu, pelatihan terstruktur, struktur ramping.', '#4F6B3A'],
        ] as $k => [$name, $desc, $color]) {
            $themes[$k] = StrategicTheme::create(['name' => $name, 'description' => $desc, 'color' => $color, 'sort' => count($themes) + 1]);
        }

        foreach ([
            ['rev', 'Fokus segmen korporasi, MICE swasta, sosial & grup; kurangi ketergantungan pada MICE pemerintah', 'pasar', 'MICE pemerintah turun akibat efisiensi anggaran; banquet shortfall terbesar.', 'dipilih'],
            ['rev', 'Tactical promotion pada tanggal low-demand, bukan diskon menyeluruh', 'harga', 'ADR Sep MTD Rp334.547 jauh di bawah budget Rp398.860 dan ARI 0,96.', 'dipilih'],
            ['rev', 'Perluas jaringan travel agent & event organizer Jawa Tengah – Jawa Timur', 'saluran', 'Konsep Kerja 2025: kota potensial Semarang, Surabaya, Solo, Yogyakarta.', 'dipilih'],
            ['exp', 'Diferensiasi "Pasundan Experience": storytelling, kuliner & ornamen Sunda', 'produk', 'Identitas Pasundan belum terasa di lobby, coffee shop, kamar (assessment 2024).', 'dipilih'],
            ['exp', 'Reposisi Executive Floor (lt. 10–11) & Executive Lounge sebagai kelas VIP', 'produk', 'Variasi tingkatan kamar sebagai keunggulan kompetitif; lounge sumber pendapatan tambahan.', 'diusulkan'],
            ['exp', 'Revitalisasi bertahap: dapur & ruang rapat lebih dulu', 'operasi', 'Risiko food safety & kehilangan event (Jayagiri, karpet, screen).', 'dipilih'],
            ['fin', 'Tiga laporan keuangan wajib tiap bulan & VHP sebagai alat operasional', 'operasi', '"Sistem adalah alat operasional bukan laporan" (MoM 23 Sep 2026).', 'dipilih'],
            ['fin', 'Konversi LPG ke CNG & pemanfaatan limbah STP', 'operasi', 'Harga LPG naik; CEO menyetujui lisan, menunggu tanda tangan.', 'dipilih'],
            ['sdm', 'Opsi alih daya supporting department (housekeeping, engineering, security, parkir)', 'organisasi', 'Konsep Kerja 2025; perlu kajian biaya-manfaat sebelum diputuskan.', 'diusulkan'],
            ['sdm', 'Pola kerja multitasking & shift berbasis okupansi', 'organisasi', 'Rasio karyawan 0,44/kamar di bawah budget 0,55; kualitas dijaga lewat pelatihan silang.', 'dipilih'],
        ] as [$th, $title, $type, $why, $status]) {
            StrategicChoice::create(['strategic_theme_id' => $themes[$th]->id, 'title' => $title, 'choice_type' => $type, 'rationale' => $why, 'status' => $status]);
        }

        // ---------------- 13 sasaran strategis
        $obj = [];
        foreach ([
            'F1' => ['keuangan', 'rev', 'Meningkatkan total pendapatan hotel', 'Mencapai anggaran pendapatan kamar, F&B/banquet, dan lain-lain 2026.', 'gm', 40],
            'F2' => ['keuangan', 'fin', 'Memulihkan likuiditas & kesehatan arus kas', 'Surplus kas positif, kewajiban terjadwal, piutang lama tertagih.', 'ca', 35],
            'F3' => ['keuangan', 'fin', 'Mengendalikan biaya operasional', 'Food cost, pembelian F&B, dan energi sesuai standar.', 'gm', 25],
            'C1' => ['pelanggan', 'rev', 'Meningkatkan okupansi, harga rata-rata & pangsa pasar', 'Okupansi, ARR, RevPAR, dan RGI ≥ kompetitor.', 'sales', 40],
            'C2' => ['pelanggan', 'exp', 'Memperkuat reputasi & pengalaman tamu', 'Rating ulasan naik, keluhan turun, setiap ulasan direspons.', 'fom', 30],
            'C3' => ['pelanggan', 'rev', 'Menumbuhkan bisnis MICE, wedding & acara sosial', 'Jumlah event naik, lost business turun.', 'sales', 30],
            'P1' => ['proses', 'fin', 'Disiplin pelaporan keuangan & pemanfaatan VHP', 'Laporan laba rugi, arus kas, neraca tepat waktu dari sistem.', 'ca', 30],
            'P2' => ['proses', 'rev', 'Mengoptimalkan saluran penjualan langsung & digital', 'Kontribusi direct booking (website, WA, walk-in) naik.', 'fom', 20],
            'P3' => ['proses', 'exp', 'Menjaga kondisi fasilitas & pemeliharaan preventif', 'Jadwal preventif terlaksana; fasilitas prioritas direvitalisasi.', 'ce', 25],
            'P4' => ['proses', 'exp', 'Standar kebersihan & kesiapan kamar', 'General cleaning terjadwal, skor inspeksi kamar tinggi.', 'ehk', 25],
            'L1' => ['sdm', 'sdm', 'Memulihkan kesejahteraan & kepercayaan karyawan', 'Gaji & service charge dibayar tepat waktu.', 'hrm', 40],
            'L2' => ['sdm', 'sdm', 'Meningkatkan kompetensi melalui pelatihan terstruktur', 'Program pelatihan terjadwal per departemen.', 'hrm', 35],
            'L3' => ['sdm', 'sdm', 'Struktur organisasi ramping & multitasking', 'Rasio karyawan per kamar efisien tanpa menurunkan layanan.', 'gm', 25],
        ] as $k => [$persp, $th, $title, $desc, $owner, $w]) {
            $obj[$k] = StrategicObjective::create(['perspective' => $persp, 'strategic_theme_id' => $themes[$th]->id, 'title' => $title, 'description' => $desc,
                'owner_id' => $u[$owner]->id, 'weight' => $w, 'sort' => count($obj) + 1]);
        }
        foreach ([
            ['F1', 'F2', 3], ['F3', 'F2', 3], ['C1', 'F1', 3], ['C3', 'F1', 3], ['C2', 'C1', 2], ['C2', 'C3', 2],
            ['P1', 'F2', 2], ['P1', 'F3', 2], ['P2', 'C1', 3], ['P3', 'C3', 3], ['P3', 'C2', 2], ['P4', 'C2', 3],
            ['L1', 'P4', 2], ['L1', 'P3', 2], ['L2', 'P1', 2], ['L2', 'P2', 2], ['L2', 'P4', 2], ['L3', 'F3', 1],
        ] as [$s, $t, $str]) {
            ObjectiveRelation::create(['source_objective_id' => $obj[$s]->id, 'target_objective_id' => $obj[$t]->id, 'strength' => $str]);
        }

        // ---------------- Deret bulanan
        $b = self::BUDGET;
        $a = self::ACTUAL;
        $rn = fn ($occ, $m) => 164 * self::DAYS[$m] * $occ / 100;
        $budget = $actual = [];
        for ($m = 1; $m <= 12; $m++) {
            $rnB = $rn($b['occ'][$m], $m);
            $room = $rnB * $b['adr'][$m] / 1000;
            $fnb = $rnB * $b['breakfast_per_rn'] + $b['outlet'][$m] + $b['banquet'][$m];
            $budget[$m] = ['room' => $room, 'fnb' => $fnb, 'banquet' => $b['banquet'][$m], 'total' => $room + $fnb + $b['other'][$m],
                'occ' => $b['occ'][$m], 'adr' => $b['adr'][$m], 'revpar' => $b['occ'][$m] * $b['adr'][$m] / 100];
            if ($m <= 9) {
                $rnA = $rn($a['occ'][$m], $m);
                $roomA = $rnA * $a['adr'][$m] / 1000;
                $bf = $m === 9 ? 200.1 : $rnA * $a['breakfast_per_rn'];
                $fnbA = $bf + $a['outlet'][$m] + $a['banquet'][$m];
                $actual[$m] = ['room' => $roomA, 'fnb' => $fnbA, 'banquet' => $a['banquet'][$m], 'total' => $roomA + $fnbA + $a['other'][$m],
                    'occ' => $a['occ'][$m], 'adr' => $a['adr'][$m], 'revpar' => $a['occ'][$m] * $a['adr'][$m] / 100];
            }
        }
        $col = fn (array $rows, string $key) => array_map(fn ($r) => round($r[$key], 2), $rows);
        $flat = fn ($v) => array_fill(1, 12, $v);
        $range = fn (array $vals) => array_combine(range(1, count($vals)), $vals);

        // [kode, sasaran, nama, satuan, arah, agregasi, pemilik, bobot, keuangan, kritis, desimal, targets[1..12], actuals[1..9], sumber_dokumen[bulan=>catatan], formula, sumber data]
        $weekly = 'GM Weekly Report 21–27 Sep 2026: MTD 1–27 Sep diekstrapolasi ke 30 hari — cocokkan dengan DRR VHP';
        $kpis = [
            ['K01', 'F1', 'Total pendapatan hotel', 'Rp juta', 'higher', 'sum', 'ca', 3, true, true, 1, $col($budget, 'total'), $col($actual, 'total'),
                [9 => $weekly], 'Room + F&B (termasuk banquet & breakfast) + other revenue', 'VHP — Daily Revenue Report / Income Audit'],
            ['K02', 'F1', 'Pendapatan kamar', 'Rp juta', 'higher', 'sum', 'sales', 2, true, false, 1, $col($budget, 'room'), $col($actual, 'room'),
                [9 => $weekly], 'Room revenue net', 'VHP — Room Revenue Breakdown'],
            ['K03', 'F1', 'Pendapatan F&B (termasuk banquet & breakfast)', 'Rp juta', 'higher', 'sum', 'fbm', 2, true, false, 1, $col($budget, 'fnb'), $col($actual, 'fnb'),
                [9 => $weekly], 'Breakfast + coffee shop + room service + lounge + cafetaria + banquet', 'VHP — Outlet Daily Sales Report'],
            ['K04', 'F1', 'Pendapatan banquet / MICE', 'Rp juta', 'higher', 'sum', 'sales', 2, true, true, 1, $col($budget, 'banquet'), $col($actual, 'banquet'),
                [9 => $weekly], 'Revenue banquet (meeting package, wedding, social event)', 'VHP — Banquet module'],
            ['K05', 'F2', 'Surplus arus kas operasional terhadap penerimaan', '%', 'higher', 'average', 'ca', 3, true, true, 2,
                [1 => 3, 3, 3, 3, 3, 3, 5, 5, 5, 5, 5, 5], $range([1.8, -2.4, -3.1, 0.6, 1.2, 0.91, 1.5, 0.4, -1.8]),
                [6 => 'Analisis Singkat Keuangan Juni 2026: penerimaan Rp2.401.524.265, pengeluaran Rp2.379.705.393, surplus Rp21.818.872'], '(Penerimaan kas − pengeluaran kas) ÷ penerimaan kas × 100', 'Laporan arus kas bulanan'],
            ['K06', 'F2', 'Rasio aset lancar terhadap kewajiban operasional', '%', 'higher', 'last', 'ca', 2, true, true, 1,
                [1 => 55, 55, 55, 55, 55, 55, 60, 63, 66, 70, 75, 80], $range([52, 49, 41, 43, 44, 44.8, 46, 45, 42]),
                [6 => 'Analisis Keuangan Juni 2026: aset lancar Rp754.902.503 ÷ kewajiban operasional Rp1.685.376.801'], '(Kas + piutang + persediaan) ÷ (utang usaha + utang revitalisasi + deposit TA + utang PBB) × 100', 'Neraca bulanan'],
            ['K07', 'F2', 'Piutang usia > 60 hari', 'Rp juta', 'lower', 'last', 'ca', 2, true, false, 1,
                [1 => 150, 150, 150, 140, 130, 120, 110, 100, 90, 75, 60, 50], $range([168, 175, 181, 160, 150, 143.07, 138, 131, 126]),
                [6 => 'Analisis Keuangan Juni 2026: piutang lama Rp143.065.998'], 'Saldo AR aging > 60 hari', 'VHP — AR Aging'],
            ['K08', 'F2', 'Pelunasan utang PBB 2025 (kumulatif)', '%', 'higher', 'last', 'ca', 1, true, false, 0,
                [7 => 15, 8 => 30, 9 => 45, 10 => 60, 11 => 80, 12 => 100], [7 => 10, 8 => 20, 9 => 25],
                [], 'Pembayaran kumulatif ÷ Rp339.306.820 × 100 (diukur mulai Juli 2026)', 'Bukti setor PBB'],
            ['K09', 'F3', 'Pembelian F&B terhadap pendapatan F&B', '%', 'lower', 'average', 'fbm', 1, true, false, 1, $flat(40),
                $range([47, 49, 58, 50, 51, 52, 48, 46, 50]), [6 => 'Analisis Keuangan Juni 2026: pembelian F&B Rp464.372.996 ≈ 52% pendapatan F&B'], 'Pembelian F&B ÷ pendapatan F&B × 100', 'VHP — Receiving report & outlet sales'],
            ['K10', 'F3', 'Food cost', '%', 'lower', 'average', 'fbm', 2, true, false, 1, $flat(35),
                $range([38.5, 40.2, 44.0, 39.6, 39.1, 41.3, 38.2, 37.6, 39.0]), [], '(Persediaan awal + pembelian − persediaan akhir) ÷ pendapatan food × 100', 'VHP — FB Reconciliation'],
            ['K11', 'F3', 'Biaya energi terhadap anggaran energi', '%', 'lower', 'average', 'ce', 1, true, false, 2, $flat(95),
                $range([57.0, 58.5, 55.2, 56.1, 57.8, 59.6, 60.3, 59.0, 53.39]), [9 => 'Engineering Energy Report Sep 2026: estimasi Rp213.345.308 ÷ budget Rp399.609.928'], 'Biaya listrik + gas + solar + air tanah ÷ anggaran energi × 100', 'Laporan energi engineering'],
            ['K12', 'C1', 'Okupansi kamar', '%', 'higher', 'average', 'sales', 3, false, true, 2, $col($budget, 'occ'), $col($actual, 'occ'),
                [8 => 'GM Weekly Report: Last Month 53,30%', 9 => $weekly.' (MTD 48,71%)'], 'Room sold ÷ room available × 100', 'VHP — Statistic'],
            ['K13', 'C1', 'Average room rate (ARR)', 'Rp ribu', 'higher', 'average', 'sales', 2, false, false, 2, $col($budget, 'adr'), $col($actual, 'adr'),
                [8 => 'GM Weekly Report: Last Month Rp345.130', 9 => 'GM Weekly Report MTD Rp334.547'], 'Room revenue ÷ room sold', 'VHP — Statistic'],
            ['K14', 'C1', 'RevPAR', 'Rp ribu', 'higher', 'average', 'sales', 2, false, false, 2, $col($budget, 'revpar'), $col($actual, 'revpar'),
                [9 => 'GM Weekly Report MTD Rp162.967'], 'Room revenue ÷ room available', 'VHP — Statistic'],
            ['K15', 'C1', 'Revenue Generation Index (RGI)', 'indeks', 'higher', 'last', 'sales', 2, false, false, 2, $flat(1.0),
                $range([0.88, 0.86, 0.84, 0.90, 0.91, 0.95, 0.94, 0.94, 0.92]), [9 => 'GM Weekly Report Sep 2026: RGI 0,92 · MPI 0,96 · ARI 0,96'], 'RevPAR GPCH ÷ RevPAR competitive set', 'Benchmark kompetitor mingguan'],
            ['K16', 'C2', 'Rating ulasan Google', 'skor', 'higher', 'last', 'fom', 2, false, false, 1, $flat(4.5),
                $range([4.3, 4.3, 4.3, 4.3, 4.3, 4.4, 4.4, 4.4, 4.4]), [9 => 'GM Weekly Report Sep 2026: Google 4,4/5 · Booking.com 9,3 · Traveloka 8,3'], 'Rating rata-rata Google Business (skala 5)', 'Google Business Profile'],
            ['K17', 'C2', 'Keluhan tamu tercatat', 'kasus', 'lower', 'sum', 'fom', 1, false, false, 0, $flat(8),
                $range([11, 9, 12, 8, 7, 6, 9, 8, 7]), [], 'Jumlah keluhan di guest comment, OTA & logbook FO', 'Logbook FO & ulasan OTA'],
            ['K18', 'C2', 'Ulasan direspons ≤ 24 jam', '%', 'higher', 'average', 'fom', 1, false, false, 0, $flat(95),
                $range([70, 72, 75, 80, 85, 88, 90, 92, 95]), [9 => 'GM Weekly Report Sep 2026: seluruh guest comment telah direply'], 'Ulasan direspons ≤ 24 jam ÷ total ulasan × 100', 'OTA extranet & Google'],
            ['K19', 'C3', 'Jumlah event banquet terlaksana', 'event', 'higher', 'sum', 'sales', 2, false, false, 0, [1 => 26, 24, 18, 30, 32, 33, 34, 30, 30, 32, 33, 38],
                $range([22, 18, 9, 27, 31, 29, 33, 30, 24]), [], 'Jumlah event (meeting package, wedding, social) yang terlaksana', 'VHP — Banquet / BEO'],
            ['K20', 'C3', 'Nilai lost business', 'Rp juta', 'lower', 'sum', 'sales', 2, false, true, 1, $flat(50),
                $range([85, 60, 40, 110, 95, 70, 120, 105, 192.5]), [9 => 'GM Weekly Report: lost business 21–27 Sep Rp49,3 jt room + Rp143,2 jt MICE = Rp192,5 jt (lengkapi 1–20 Sep)'], 'Nilai potensi pendapatan yang hilang (loss), di luar postponed', 'Sales — lost business report'],
            ['K21', 'P1', 'Laporan keuangan bulanan lengkap (PnL, arus kas, neraca)', 'hari', 'lower', 'average', 'ca', 1, false, false, 0, [1 => 15, 15, 15, 12, 12, 12, 10, 10, 10, 10, 10, 10],
                $range([25, 22, 20, 18, 15, 14, 12, 12, 11]), [], 'Jumlah hari setelah tutup bulan sampai tiga laporan diterbitkan', 'Accounting'],
            ['K22', 'P2', 'Kontribusi direct booking terhadap room revenue', '%', 'higher', 'average', 'fom', 1, false, false, 1, [1 => 8, 8, 8, 10, 10, 10, 12, 12, 12, 15, 15, 15],
                $range([6.5, 7.0, 7.2, 8.0, 8.8, 9.5, 10.2, 10.6, 11.0]), [9 => 'GM Weekly Report: promo WA "Septembersama" 212 RN, Rp84.151.778, ARR Rp396.942 = 11% room revenue'], 'Room revenue dari website, WhatsApp, walk-in ÷ total room revenue × 100', 'VHP — Source of Business'],
            ['K23', 'P3', 'Kepatuhan jadwal pemeliharaan preventif', '%', 'higher', 'average', 'ce', 2, false, false, 0, $flat(90),
                $range([55, 58, 60, 62, 65, 68, 70, 72, 74]), [], 'Pekerjaan preventif terlaksana ÷ terjadwal × 100', 'Laporan engineering mingguan'],
            ['K24', 'P4', 'Kamar general cleaning / refresh', 'kamar', 'higher', 'sum', 'ehk', 1, false, false, 0, $flat(80),
                $range([40, 45, 30, 60, 70, 72, 75, 78, 82]), [], 'Jumlah kamar selesai general cleaning (target 20 kamar/minggu)', 'Laporan housekeeping'],
            ['K25', 'P4', 'Skor inspeksi kebersihan kamar', '%', 'higher', 'average', 'ehk', 2, false, false, 0, $flat(90),
                $range([82, 83, 81, 84, 85, 86, 86, 87, 88]), [], 'Rata-rata skor checklist inspeksi kamar (defect list)', 'Room inspection checklist'],
            ['K26', 'L1', 'Ketepatan pembayaran gaji & service charge', '%', 'higher', 'average', 'hrm', 1, false, true, 0, $flat(100),
                $range([50, 50, 50, 100, 50, 100, 100, 100, 100]), [], '100 = gaji & service tepat waktu; 50 = salah satu terlambat; 0 = keduanya terlambat', 'Payroll HRD'],
            ['K27', 'L2', 'Jam pelatihan per karyawan', 'jam', 'higher', 'average', 'hrm', 1, false, false, 1, $flat(2),
                $range([0.3, 0.4, 0.2, 0.8, 1.0, 1.1, 1.3, 1.4, 1.5]), [], 'Total jam pelatihan ÷ jumlah karyawan', 'Training record HRD'],
            ['K28', 'L3', 'Rasio karyawan per kamar', 'rasio', 'lower', 'last', 'hrm', 1, false, false, 2, $flat(0.55),
                $range([0.47, 0.47, 0.46, 0.46, 0.45, 0.45, 0.45, 0.44, 0.44]), [9 => 'GM Weekly Report Sep 2026: 72 karyawan (PKWT 34, daily worker 38) ÷ 164 kamar = 0,44; budget 0,55'], 'Total karyawan ÷ jumlah kamar', 'HRD'],
        ];

        $kpiModels = [];
        foreach ($kpis as [$code, $o, $name, $unit, $dir, $agg, $owner, $w, $fin, $crit, $dec, $targets, $actuals, $docs, $formula, $source]) {
            $annual = match ($agg) {
                'sum' => array_sum($targets),
                'average' => array_sum($targets) / count($targets),
                default => end($targets),
            };
            $kpi = Kpi::create([
                'strategic_objective_id' => $obj[$o]->id, 'name' => $name, 'unit' => $unit, 'direction' => $dir, 'aggregation' => $agg,
                'frequency' => 'bulanan', 'owner_id' => $u[$owner]->id, 'weight' => $w, 'is_financial' => $fin, 'is_critical' => $crit, 'decimals' => $dec,
                'annual_target' => round($annual, 4), 'baseline' => reset($actuals), 'formula' => $formula, 'data_source' => $source,
                'description' => 'Kode referensi '.$code.'.',
            ]);
            foreach ($targets as $m => $t) {
                KpiTarget::create(['kpi_id' => $kpi->id, 'month' => $m, 'target' => $t]);
            }
            foreach ($actuals as $m => $v) {
                $fromDoc = isset($docs[$m]);
                $extrapolated = $fromDoc && str_contains($docs[$m], 'diekstrapolasi');
                $status = 'draf';
                $extra = [];
                if ($fromDoc && $fin && ! $extrapolated) {
                    $status = 'terverifikasi';
                    $extra = ['verified_by' => $u['ca']->id, 'verified_at' => '2026-10-07 15:00:00', 'verification_note' => 'Sesuai dokumen sumber.'];
                }
                if ($code === 'K10' && $m === 3) {
                    $status = 'dikembalikan';
                    $extra = ['returned_by' => $u['ca']->id, 'returned_at' => '2026-10-15 09:30:00',
                        'return_note' => 'Food cost Maret masih memakai penangguhan beban (deferred cost). Hitung ulang dengan pemakaian riil sesuai keputusan Timwas 3 Jun 2026.'];
                }
                KpiActual::create([
                    'kpi_id' => $kpi->id, 'month' => $m, 'actual' => $v, 'status' => $status,
                    'is_projection' => ! $fromDoc || $extrapolated,
                    'notes' => $fromDoc ? 'Sumber: '.$docs[$m] : 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.',
                    'submitted_by' => $u[$owner]->id, 'submitted_at' => '2026-10-14 10:00:00',
                ] + $extra);
            }
            $kpiModels[$code] = $kpi;
        }

        // ---------------- Tinjauan kinerja
        $reviews = [];
        $reviews['timwas_jun'] = PerformanceReview::create([
            'title' => 'Rapat GBK–GPCH: stok gudang, penangguhan beban & purchasing', 'review_type' => 'rapat_timwas', 'review_date' => '2026-06-03',
            'period_label' => 'Mei 2026', 'chair' => 'Bapak Wilfred', 'venue' => 'Ruang Sangkuriang',
            'participants' => 'Ibu Lena, Pak Irawan, Pak Joice, Pak Miko, Pak Daniel, Bu Yuli, Pak Indra',
            'summary' => "1. Penutupan rekening lama: surat kuasa penutupan rekening BRI diminta; BJB masih proses karena Ibu Lena kehilangan 2 lembar cek.\n2. Penjelasan stok gudang Rp667,5 jt (Bpk Irawan Trimulia): Feb–Mar dilakukan deferred cost (penangguhan pembebanan food cost) saat revenue rendah, program Iftar menaikkan food cost dan THR menaikkan payroll; dilakukan untuk menjaga GOP; dibebankan ke bulan berikutnya dan habis dalam 1 tahun fiskal.\n3. Potongan SP uang service dibagikan rata ke semua karyawan di bulan yang sama kecuali yang dikenakan SP.",
            'decisions' => "A. Penangguhan beban hanya boleh bila dalam satu bulan revenue rendah dan fixed cost membesar.\nB. Timwas memutuskan cost yang ditangguhkan dibebankan secara riil; tidak ada lagi penangguhan beban pada data inventory.\nC. Pak Daniel ditugaskan menjadi Purchasing GPCH, didampingi & ditraining Pak Rustamadji; payroll, service, BPJS dibayarkan Manajemen GPCH.\nD. Administrasi HRM dilengkapi; job description disiapkan CA & GM; struktur direct report ke GM.",
            'follow_up' => 'Accounting mendata cost yang ditangguhkan vs riil; penutupan rekening BJB & BRI.',
            'status' => 'final', 'recorded_by' => $u['koordinator']->id,
        ]);
        $reviews['q2'] = PerformanceReview::create([
            'title' => 'Tinjauan Keuangan Juni 2026 (kuartal II)', 'review_type' => 'kuartalan', 'review_date' => '2026-07-15', 'period_label' => 'Juni 2026 / Q2',
            'chair' => 'General Manager', 'venue' => 'Ruang Niskala', 'participants' => 'GM, Chief Accountant, kepala departemen',
            'summary' => "Operasional masih menghasilkan arus kas positif namun sangat tipis: penerimaan Rp2.401.524.265, pengeluaran Rp2.379.705.393, surplus Rp21.818.872 (0,91%).\nAset lancar Rp754.902.503 (bank Rp331,8 jt, piutang Rp285,2 jt, persediaan Rp137,9 jt) hanya menutup 45% kewajiban operasional Rp1.685.376.801 (utang usaha Rp580,9 jt, utang revitalisasi Rp183,0 jt, deposit TA Rp582,1 jt, utang PBB 2025 Rp339,3 jt); kekurangan modal kerja ±Rp930 jt.\nPiutang lama Rp143,1 jt; pembelian F&B Rp464,4 jt (78% dari seluruh pembelian, ±52% pendapatan F&B); utang CEO jangka panjang Rp30.910.787.939.",
            'decisions' => "1. Susun proyeksi arus kas mingguan.\n2. Percepat penagihan piutang (korporasi, travel agent, penyelenggara kegiatan).\n3. Kendalikan pembelian & food cost (resep, porsi, harga jual, waste, konsumsi karyawan, complimentary, selisih stok, kontrak pemasok).\n4. Jaga penggunaan deposit OTA.\n5. Jadwalkan pembayaran pemasok dan PBB.\n6. Restrukturisasi utang CEO (tenor, subordinasi, konversi modal).",
            'status' => 'final', 'recorded_by' => $u['koordinator']->id,
        ]);
        foreach ([[7, '2026-08-10', 'Juli 2026'], [8, '2026-09-10', 'Agustus 2026']] as [$mm, $date, $label]) {
            $reviews['rm_'.$mm] = PerformanceReview::create([
                'title' => 'Rapat Manajemen Bulanan — '.$label, 'review_type' => 'rapat_manajemen', 'review_date' => $date, 'period_label' => $label,
                'chair' => 'General Manager', 'venue' => 'Ruang Niskala', 'participants' => 'GM & seluruh kepala departemen',
                'summary' => 'PROYEKSI — ringkasan disusun dari data realisasi Arah GPCH; lengkapi dengan notulen asli rapat '.$label.'.',
                'decisions' => 'Lengkapi dari notulen asli.', 'status' => 'draf', 'recorded_by' => $u['koordinator']->id,
            ]);
        }
        $reviews['rm_sep'] = PerformanceReview::create([
            'title' => 'Rapat Manajemen — Action Plan Revenue Recovery 21–30 Sep 2026', 'review_type' => 'rapat_manajemen', 'review_date' => '2026-09-23',
            'period_label' => 'September 2026', 'chair' => 'Bapak Yodi S. Ibrahim & Bapak I.G. Wiwin S.', 'venue' => 'Ruang Niskala',
            'participants' => 'Bpk. Indra, Bpk. Wahyudin, Bpk. Anto, Bpk. Rizki, Bpk. Ujang, Pak Asep Agus, Ibu Irina, Bpk. Daniel, Ibu Yuyun, Bpk. Dio',
            'summary' => "Info 3P minggu ke-3 September 2026 oleh Management.\nA. Room revenue: tingkatkan occupancy sekaligus jaga ADR — review pickup harian & forecast, push corporate/local account & group, optimalkan OTA di tanggal okupansi rendah, tactical promotion (bukan diskon menyeluruh), daily review Occ/ADR/RevPAR.\nB. Banquet — prioritas utama: shortfall Rp681,95 jt; follow up database corporate & EO, review pipeline, paket meeting/wedding/gathering/social, daily pipeline report (inquiry, quotation, follow-up, tentative, confirmed, revenue potential).\nC. Outlet F&B (coffee shop, room service, lounge): bundle promo, upselling in-house guest, promo room service via kamar/channel, breakfast upselling untuk room-only, cross-selling, review jam operasional.\nD. Other revenue: pertahankan healthy club, laundry, parkir; buat paket promosi spa.",
            'decisions' => "Usulan Bpk. Wimpy (MB), Bpk. Yodi & Bpk. Wiwin:\n• Biaya ke depan meningkat, tujuan owner hanya satu: hasil.\n• Kompetitor mencari pasar, bukan mencuri rejeki kita — manjakan pelanggan setia.\n• Jangan duduk bersepakat tapi action tidak bersepakat; perkuat teamwork.\n• Cari potensi revenue yang sedang booming (mis. pameran mobil listrik); semua HOD mencari peluang event.\n• CEO ingin melihat penyebab inefisiensi di GP — analisa & kaji; pemborosan dikurangi.\n• Ketegasan pimpinan = teguran sesuai peraturan, bukan pressure.\n• VHP: menu dashboard, notifikasi approval PR, supplier & artikel casual, approval sign form PR — follow up ke VHP (Ticket #181ADD).\n• Jumat 13.00: data budgeting & kendala operasional tiap departemen.\n• F&B wajib punya data perencanaan di sistem; semua HOD punya akses tambah item PR.\n• Sistem adalah alat operasional, bukan laporan; buat PNP VHP untuk HOD.\n• Buat timeline pekerjaan beserta PIC; usulan di MoM selalu ditindaklanjuti minggu berikutnya.",
            'follow_up' => 'Timeline pekerjaan & PIC; tindak lanjut MoM pada weekly report berikutnya.',
            'status' => 'final', 'recorded_by' => $u['koordinator']->id,
        ]);
        $reviews['weekly_sep'] = PerformanceReview::create([
            'title' => 'GM Weekly Report 21–27 September 2026', 'review_type' => 'weekly_gm', 'review_date' => '2026-09-28', 'period_label' => '21–27 Sep 2026 (MTD)',
            'chair' => 'General Manager', 'venue' => 'Ruang Niskala',
            'participants' => 'HR (Anto), Purchasing (Daniel), Accounting (Indra), Engineering (Wahyudin), FBP & FBS, Front Office (Rizki), Sales Marketing (Irina), Housekeeping (Wina)',
            'summary' => "MTD: room sold 2.167 dari 4.428 (Occ 48,71% vs budget 52,54%), ADR Rp334.547 vs Rp398.860, RevPAR Rp162.967, room revenue Rp721,6 jt (77,6% budget).\nBreakfast Rp180,1 jt (164,8%), coffee shop Rp13,9 jt (28,2%), room service Rp11,4 jt (20,4%), lounge Rp7,5 jt (24,0%), cafetaria Rp7,1 jt (62,5%), banquet Rp430,7 jt (21,85% menurut laporan) — F&B Rp650,8 jt (33,4%).\nTotal hotel revenue Rp1.409.097.543 = 51,60% budget Rp2.397.993.249 (shortfall Rp988.895.706); −17,62% vs bulan lalu, +4,64% vs tahun lalu.\nKompetitor: GPCH peringkat 3 (RGI 0,92). Lost business Rp192,5 jt; postponed Rp15,75 jt; cancel Rp31,3 jt.\nEnergi Sep ±Rp213,3 jt (53,39% budget). Karyawan 72 (rasio 0,44). Engineering: panel lift 1 on progress, pompa kolam baru terpasang namun sand filter bocor, LPG→CNG menunggu tanda tangan CEO.",
            'decisions' => "Fokus revenue recovery sisa September: tactical promotion tanggal low occupancy, jaga ADR, review pickup & cancellation harian, fokus corporate/government/group/OTA, monitoring Occ+ADR+RevPAR harian; banquet: review pipeline, sales call, tactical package, follow-up quotation, tarik event maju; outlet: review traffic, average check, jam operasional, promosi; pertahankan breakfast & healthy club.",
            'follow_up' => 'FO: promo Oktober (walk-in 15%, last minute weekdays 10%, early bird 3/7/14 hari), business review Traveloka & Trip.com. Sales: telemarketing, IG live house tour, budgeting 2027. HR: GM baru Ibu Vivera join 1 Okt 2026; LOI EHK baru.',
            'status' => 'final', 'recorded_by' => $u['koordinator']->id,
        ]);
        ReviewNote::create(['performance_review_id' => $reviews['timwas_jun']->id, 'user_id' => $u['wilfred']->id,
            'note' => 'Timwas akan memeriksa data inventory bulan Juli–Agustus untuk memastikan tidak ada lagi penangguhan beban.']);
        ReviewNote::create(['performance_review_id' => $reviews['weekly_sep']->id, 'user_id' => $u['wilfred']->id,
            'note' => 'Catatan pengawasan: shortfall banquet harus disertai daftar pipeline per event dan alasan loss. Mohon analisis penyebab inefisiensi (permintaan CEO) disampaikan pada rapat manajemen Oktober.']);

        return ['objectives' => $obj, 'kpis' => $kpiModels, 'themes' => $themes, 'reviews' => $reviews];
    }
}
