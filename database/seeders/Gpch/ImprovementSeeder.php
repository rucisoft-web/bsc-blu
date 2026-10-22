<?php

namespace Database\Seeders\Gpch;

use App\Models\CorrectiveAction;
use App\Models\Finding;
use App\Models\InitiativeActivity;
use App\Models\InitiativeBudget;
use App\Models\InitiativeMilestone;
use App\Models\StrategicInitiative;

/** 11 inisiatif strategis + aktivitas, milestone, anggaran; temuan & tindakan korektif awal. */
class ImprovementSeeder
{
    public function seed(array $u, array $perf): array
    {
        $o = $perf['objectives'];
        $th = $perf['themes'];
        $ini = [];
        $defs = [
            'vhp' => ['Integrasi & Optimalisasi VHP Cloud', 'Lengkapi data master back office (saldo awal, aging AR/AP, supplier, artikel, store, cost center) dan aktifkan dashboard, approval PR, artikel casual agar VHP menjadi alat operasional dan sumber laporan keuangan.', 'fin', 'edp', '2026-04-01', '2026-12-31', 'berjalan', 4, 4, 2, 2, ['P1', 'F2'],
                'Laporan BS & PnL dihasilkan dari VHP; semua HOD aktif memakai VHP.'],
            'cash' => ['Penyehatan Arus Kas & Restrukturisasi Kewajiban', 'Proyeksi kas mingguan, penagihan piutang lama, rekening deposit OTA terpisah, jadwal pemasok & cicilan PBB 2025, usulan restrukturisasi utang CEO.', 'fin', 'ca', '2026-07-01', '2027-03-31', 'berjalan', 5, 5, 4, 3, ['F2'],
                'Surplus kas ≥ 5%, rasio aset lancar ≥ 80%, PBB 2025 lunas.'],
            'brand' => ['Re-branding "Pasundan Experience"', 'Storytelling Sunda di website (Alaric), konten IG/TikTok/YouTube, influencer staycation, ornamen Sunda lobby & coffee shop, kristalisasi marmer lobby.', 'exp', 'sales', '2026-03-01', '2026-12-31', 'berjalan', 4, 3, 3, 4, ['C1', 'C2', 'P2'],
                'Rating Google 4,5; kontribusi direct booking 15%.'],
            'partner' => ['Kemitraan Travel Agent & Event Organizer Jateng–Jatim', 'Table top & travel mart, kontrak TA/EO di Semarang, Solo, Yogyakarta, Surabaya; komisi khusus & paket all-in.', 'rev', 'sales', '2026-05-01', '2027-06-30', 'berjalan', 4, 3, 2, 2, ['C1', 'C3'],
                'Minimal 10 kontrak TA/EO aktif dan 5 event grup per kuartal dari luar Bandung.'],
            'recovery' => ['Revenue Recovery Q4 — Room & Banquet', 'Action plan rapat 23 Sep 2026: review pickup harian, tactical promotion low-demand dates, daily pipeline report, paket meeting/wedding/gathering, event olahraga & exhibition, konsep tahun baru.', 'rev', 'sales', '2026-09-21', '2026-12-31', 'berjalan', 5, 5, 2, 1, ['F1', 'C1', 'C3'],
                'Pendapatan Q4 ≥ 85% anggaran; banquet ≥ Rp900 jt/bulan.'],
            'lounge' => ['Revitalisasi Executive Floor & Executive Lounge', 'Kembalikan fungsi executive floor (lt. 10–11) dengan ornamen Pasundan, amenities lebih mewah; lounge untuk VIP: breakfast, afternoon tea & supper.', 'exp', 'fom', '2026-11-01', '2027-06-30', 'direncanakan', 3, 2, 3, 4, ['C1', 'C2'],
                'ARR executive naik ≥ 20%; pendapatan lounge baru.'],
            'foodcost' => ['Pengendalian Food Cost & Pembelian F&B', 'Standard recipe ala carte & event di VHP, hunting harga pasar untuk DML, stop deferred cost, stock opname bulanan, revisi harga menu, proposal depo air minum & utensil.', 'fin', 'fbm', '2026-06-15', '2026-12-31', 'berjalan', 4, 5, 2, 1, ['F3', 'P1'],
                'Food cost ≤ 35%, pembelian F&B ≤ 40% pendapatan F&B.'],
            'facility' => ['Revitalisasi Fasilitas Prioritas', 'Epoxy dapur & pastry, karpet/screen/AV ruang rapat & kajian plafon Jayagiri, panel lift 1, repaint 20 kamar, pompa & sand filter kolam.', 'exp', 'ce', '2026-08-01', '2027-03-31', 'berjalan', 4, 4, 4, 5, ['P3', 'C3', 'C2'],
                'Tidak ada lagi event pindah karena kondisi ruang; dapur memenuhi standar higiene.'],
            'energy' => ['Efisiensi Energi: Konversi LPG→CNG & Pemanfaatan Limbah STP', 'Konversi LPG ke CNG (menunggu tanda tangan CEO), pemanfaatan limbah STP (vendor Jayawiratama), lampu PLC→LED downlight, monitoring energi mingguan.', 'fin', 'ce', '2026-09-01', '2027-02-28', 'berjalan', 3, 3, 3, 3, ['F3'],
                'Biaya energi turun ≥ 10% dibanding Sep 2026.'],
            'people' => ['Pelatihan Terstruktur & Pemulihan Kesejahteraan Karyawan', 'Gaji & service charge tepat waktu, kalender refresh training per departemen, evaluasi kinerja bulanan, program PKL, rekrutmen CE & EHK.', 'sdm', 'hrm', '2026-04-01', '2026-12-31', 'berjalan', 4, 4, 2, 2, ['L1', 'L2', 'L3'],
                '100% pembayaran tepat waktu; 2 jam pelatihan/karyawan/bulan.'],
            'laundry' => ['Layanan Laundry & Pressing Tamu + General Cleaning', 'Layanan setrika/pressing murah sebagai nilai tambah convention hotel; general cleaning 20 kamar/minggu & kristalisasi area publik.', 'exp', 'ehk', '2026-07-01', '2026-12-31', 'berjalan', 2, 2, 2, 2, ['P4', 'C2'],
                'Pendapatan laundry naik; skor inspeksi kamar ≥ 90%.'],
        ];
        foreach ($defs as $k => [$title, $desc, $theme, $owner, $start, $end, $status, $imp, $urg, $risk, $bud, $objs, $outcome]) {
            $ini[$k] = StrategicInitiative::create(['title' => $title, 'description' => $desc, 'strategic_theme_id' => $th[$theme]->id, 'owner_id' => $u[$owner]->id,
                'start_date' => $start, 'end_date' => $end, 'status' => $status, 'impact' => $imp, 'urgency' => $urg, 'risk' => $risk, 'budget_level' => $bud,
                'expected_outcome' => $outcome]);
            $ini[$k]->objectives()->sync(collect($objs)->map(fn ($x) => $o[$x]->id));
        }

        // aktivitas: [inisiatif, nama, pemilik, mulai, tenggat, progres, catatan]
        $acts = [
            ['vhp', 'Follow up menu dashboard VHP Cloud (Ticket #181ADD)', 'edp', '2026-09-24', '2026-10-15', 60, 'Menunggu jadwal remote VHP.'],
            ['vhp', 'Notifikasi approval PR & approval sign pada form PR', 'edp', '2026-09-24', '2026-10-31', 40, null],
            ['vhp', 'Buat supplier & artikel casual di VHP (tenaga kerja casual FB, HK, FO, Eng, Security)', 'purchasing', '2026-09-24', '2026-10-10', 100, 'Selesai dibuat.'],
            ['vhp', 'Input saldo awal, aging AR/AP, artikel inventory, store & cost center', 'ca', '2026-07-01', '2026-11-30', 45, null],
            ['vhp', 'PNP (panduan) VHP untuk seluruh HOD + akses penambahan item PR', 'edp', '2026-10-01', '2026-11-15', 20, null],
            ['cash', 'Proyeksi arus kas mingguan', 'ca', '2026-07-01', '2026-07-31', 100, 'Rutin setiap Senin.'],
            ['cash', 'Penagihan piutang lama Rp143 jt (korporasi, TA, EO)', 'ca', '2026-07-01', '2026-10-31', 55, 'Sisa piutang > 60 hari ±Rp126 jt.'],
            ['cash', 'Rekening terpisah untuk deposit TA/OTA', 'ca', '2026-08-01', '2026-09-30', 20, 'Menunggu penutupan rekening lama BJB.'],
            ['cash', 'Jadwal cicilan PBB 2025 dengan Bapenda', 'ca', '2026-07-01', '2026-12-31', 25, null],
            ['cash', 'Usulan restrukturisasi utang CEO Rp30,91 M ke pemilik', 'ca', '2026-09-01', '2026-11-30', 15, null],
            ['brand', 'Redesign website storytelling & booking engine (Alaric)', 'sales', '2026-03-01', '2026-06-30', 100, null],
            ['brand', 'Konten rutin IG/TikTok & live IG house tour', 'rika', '2026-04-01', '2026-12-31', 60, 'Live IG house tour dijadwalkan Okt 2026.'],
            ['brand', 'Ornamen Sunda lobby & coffee shop (center piece, hiasan buffet)', 'fbm', '2026-07-01', '2026-10-31', 30, null],
            ['brand', 'Kristalisasi marmer lobby & area depan CS', 'ehk', '2026-09-01', '2026-11-30', 25, null],
            ['partner', 'Table top & business matching Jogja / ASITA travel mart (budgeting 2027)', 'sales', '2026-09-15', '2026-12-15', 30, null],
            ['partner', 'Renew kontrak Trip.com & business review Traveloka', 'fom', '2026-09-28', '2026-10-31', 50, null],
            ['partner', 'Database EO/WO Bandung & kerja sama wedding expo 2027', 'arsy', '2026-09-01', '2026-11-30', 40, null],
            ['recovery', 'Daily pipeline report (inquiry → confirmed)', 'sales', '2026-09-23', '2026-09-30', 100, 'Berjalan harian sejak 23 Sep.'],
            ['recovery', 'Tactical promotion tanggal low-demand (walk-in 15%, last minute weekdays 10%, early bird)', 'fom', '2026-09-28', '2026-10-31', 70, null],
            ['recovery', 'Follow up Piala Gubernur (est. Rp153,8 jt) & PORPROV (est. Rp45 jt)', 'sales', '2026-09-24', '2026-10-20', 50, null],
            ['recovery', 'Konsep acara Tahun Baru 2027 dengan Marcom & F&B', 'sales', '2026-10-01', '2026-11-15', 15, null],
            ['recovery', 'Paket promosi spa & bundling outlet F&B', 'fbm', '2026-10-01', '2026-10-31', 30, null],
            ['lounge', 'Desain ulang lounge & executive floor', 'fom', '2026-11-01', '2027-01-31', 0, null],
            ['lounge', 'Paket amenities executive', 'ehk', '2026-12-01', '2027-02-28', 0, null],
            ['foodcost', 'Input standard recipe menu ala carte di VHP', 'fbm', '2026-07-01', '2026-10-15', 70, null],
            ['foodcost', 'Hunting harga pasar untuk DML & kontrak pemasok', 'purchasing', '2026-06-15', '2026-12-31', 60, null],
            ['foodcost', 'Stock opname bulanan & stop penangguhan beban', 'ca', '2026-06-15', '2026-07-31', 100, 'Sesuai keputusan Timwas 3 Jun 2026.'],
            ['foodcost', 'Proposal depo air minum & utensil kitchen', 'purchasing', '2026-09-01', '2026-10-15', 60, null],
            ['foodcost', 'Revisi harga & cetak menu ala carte', 'fbm', '2026-09-15', '2026-10-31', 40, null],
            ['facility', 'Penggantian panel lift 1 (vendor Elpa Global Techno)', 'ce', '2026-09-20', '2026-10-04', 80, 'Wiring & display HOP sesuai timeline; uji fungsi menyusul.'],
            ['facility', 'Install pompa kolam Hayward 2HP & perbaikan sand filter', 'ce', '2026-09-28', '2026-10-10', 100, 'Pompa terpasang 28 Sep; sand filter selesai diperbaiki.'],
            ['facility', 'Repaint spot walls 20 kamar', 'ce', '2026-09-28', '2026-10-04', 60, '6 kamar selesai hari kedua.'],
            ['facility', 'Epoxy lantai dapur & pastry (3–5 mm)', 'ce', '2026-11-01', '2027-01-31', 0, null],
            ['facility', 'Karpet, screen & kajian plafon ruang Jayagiri', 'ce', '2026-10-15', '2027-03-31', 10, 'Screen baru sudah dibeli.'],
            ['energy', 'Tanda tangan CEO untuk mutasi LPG→CNG', 'ce', '2026-09-20', '2026-10-15', 50, 'Disetujui lisan, menunggu tanda tangan.'],
            ['energy', 'Koordinasi pemanfaatan limbah STP (Jayawiratama)', 'ce', '2026-09-20', '2026-11-30', 20, null],
            ['energy', 'Penggantian lampu PLC → LED downlight (coffee shop, lobby, FO)', 'rara', '2026-09-23', '2026-10-31', 55, null],
            ['people', 'Jadwal pembayaran gaji & service charge tepat waktu', 'hrm', '2026-04-01', '2026-12-31', 75, null],
            ['people', 'Kalender refresh training per departemen', 'hrm', '2026-05-01', '2026-12-31', 55, 'Sep: F&B mise en place, engineering dokumentasi, FO reschedule OTA.'],
            ['people', 'Rekrutmen Chief Engineer & Executive Housekeeper (LOI EHK)', 'hrm', '2026-09-01', '2026-10-31', 50, null],
            ['people', 'Evaluasi kinerja bulanan per individu', 'hrm', '2026-06-01', '2026-12-31', 35, null],
            ['laundry', 'General cleaning 20 kamar per minggu', 'ujang', '2026-07-01', '2026-12-31', 60, null],
            ['laundry', 'Kajian layanan pressing & setrika tamu', 'ehk', '2026-09-01', '2026-10-31', 30, null],
        ];
        foreach ($acts as [$k, $name, $owner, $start, $due, $prog, $note]) {
            InitiativeActivity::create(['strategic_initiative_id' => $ini[$k]->id, 'name' => $name, 'owner_id' => $u[$owner]->id, 'start_date' => $start, 'due_date' => $due,
                'weight' => 1, 'progress' => $prog, 'last_update_note' => $note]);
        }

        // milestone: [inisiatif, nama, tenggat, tercapai]
        foreach ([
            ['vhp', 'Modul back office VHP berjalan dengan saldo awal', '2026-11-30', false], ['vhp', 'Neraca & laba rugi dihasilkan dari VHP', '2026-12-31', false],
            ['cash', 'Proyeksi kas mingguan rutin', '2026-07-31', true], ['cash', 'Rekening deposit OTA terpisah aktif', '2026-10-31', false], ['cash', 'Kesepakatan restrukturisasi utang CEO', '2027-03-31', false],
            ['brand', 'Website storytelling live', '2026-06-30', true], ['brand', 'Lobby bernuansa Sunda', '2026-11-30', false],
            ['partner', '5 kontrak TA/EO luar Bandung', '2026-12-31', false],
            ['recovery', 'Pipeline report harian berjalan', '2026-09-30', true], ['recovery', 'Event Piala Gubernur confirmed', '2026-10-20', false], ['recovery', 'Paket Tahun Baru diluncurkan', '2026-11-15', false],
            ['lounge', 'Desain disetujui pemilik', '2027-01-31', false],
            ['foodcost', 'Stop penangguhan beban di inventory', '2026-07-31', true], ['foodcost', 'Standard recipe 100% menu ala carte', '2026-10-31', false],
            ['facility', 'Lift 1 beroperasi dengan panel baru', '2026-10-10', false], ['facility', 'Kolam beroperasi normal (pompa & sand filter)', '2026-10-10', true], ['facility', 'Dapur epoxy selesai', '2027-01-31', false],
            ['energy', 'CNG beroperasi', '2027-01-31', false],
            ['people', 'Gaji & service tepat waktu 3 bulan berturut-turut', '2026-09-30', true], ['people', 'CE & EHK definitif bergabung', '2026-11-30', false],
            ['laundry', 'Layanan pressing diluncurkan', '2026-11-30', false],
        ] as [$k, $name, $due, $done]) {
            InitiativeMilestone::create(['strategic_initiative_id' => $ini[$k]->id, 'name' => $name, 'due_date' => $due, 'is_achieved' => $done,
                'achieved_at' => $done ? $due : null, 'owner_id' => $ini[$k]->owner_id, 'weight' => 1]);
        }

        // anggaran: [inisiatif, item, kategori, rencana, realisasi, sumber]
        foreach ([
            ['vhp', 'Langganan VHP Cloud 2026', 'opex', 96000000, 72000000, 'Operasional'], ['vhp', 'Tablet dashboard HOD', 'capex', 12000000, 0, 'Operasional'],
            ['cash', 'Pendampingan hukum restrukturisasi utang', 'opex', 25000000, 0, 'Operasional'],
            ['brand', 'Produksi video & foto profesional', 'opex', 35000000, 18500000, 'Marketing'], ['brand', 'Influencer & paid ads', 'opex', 20000000, 8000000, 'Marketing'],
            ['brand', 'Ornamen & artwork Sunda lobby', 'capex', 45000000, 12000000, 'Revitalisasi'], ['brand', 'Kristalisasi marmer lobby', 'opex', 30000000, 0, 'Revitalisasi'], ['brand', 'Redesign website', 'opex', 25000000, 25000000, 'Marketing'],
            ['partner', 'Table top Jogja (2 delegate × Rp5,5 jt)', 'opex', 11000000, 0, 'Marketing'], ['partner', 'ASITA West Java Travel Mart', 'opex', 6000000, 0, 'Marketing'],
            ['recovery', 'WA blast & promo materials', 'opex', 8000000, 5200000, 'Marketing'], ['recovery', 'Talent & produksi acara Tahun Baru', 'opex', 40000000, 0, 'F&B'],
            ['lounge', 'Refurbish executive lounge', 'capex', 180000000, 0, 'Revitalisasi'], ['lounge', 'Amenities executive floor', 'opex', 35000000, 0, 'Rooms'],
            ['foodcost', 'Utensil kitchen', 'capex', 28000000, 0, 'F&B'], ['foodcost', 'Depo air minum', 'capex', 18000000, 0, 'F&B'], ['foodcost', 'Cetak menu ala carte', 'opex', 4500000, 0, 'F&B'],
            ['facility', 'Panel lift 1 (Elpa Global Techno)', 'capex', 165000000, 99000000, 'Utang revitalisasi'], ['facility', 'Pompa kolam Hayward 2HP', 'capex', 14500000, 14500000, 'Revitalisasi'],
            ['facility', 'Screen proyektor ruang rapat', 'capex', 9000000, 9000000, 'Revitalisasi'], ['facility', 'Repaint 20 kamar', 'opex', 16000000, 6000000, 'Engineering'],
            ['facility', 'Epoxy dapur & pastry', 'capex', 85000000, 0, 'Revitalisasi'], ['facility', 'Karpet ruang rapat', 'capex', 120000000, 0, 'Revitalisasi'],
            ['energy', 'Instalasi CNG', 'capex', 25000000, 0, 'Engineering'], ['energy', 'Lampu LED downlight', 'capex', 12000000, 7800000, 'Engineering'],
            ['people', 'Program pelatihan & sertifikasi', 'opex', 15000000, 4500000, 'HRD'],
            ['laundry', 'Peralatan pressing & setrika', 'capex', 18000000, 0, 'Housekeeping'], ['laundry', 'Chemical general cleaning', 'opex', 6000000, 3200000, 'Housekeeping'],
        ] as [$k, $item, $cat, $plan, $real, $fund]) {
            InitiativeBudget::create(['strategic_initiative_id' => $ini[$k]->id, 'item' => $item, 'category' => $cat, 'planned_amount' => $plan, 'realized_amount' => $real,
                'realization_date' => $real > 0 ? '2026-09-30' : null, 'funding_source' => $fund,
                'notes' => 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.',
                'verified_by' => $real > 0 ? $u['ca']->id : null, 'verified_at' => $real > 0 ? '2026-10-07 15:00:00' : null]);
        }
        foreach ($ini as $i) {
            $i->update(['budget_planned' => $i->budgets()->sum('planned_amount')]);
            $i->recalculateProgress();
        }

        // ---------------- Temuan & tindakan korektif
        $k = $perf['kpis'];
        $r = $perf['reviews'];
        $findings = [
            ['Revenue shortfall September 2026', 'Total revenue MTD 21–27 Sep Rp1,41 M = 51,6% budget (shortfall Rp988,9 jt); banquet shortfall Rp681,95 jt menjadi penyumbang terbesar.', 'tinjauan', 'weekly_sep', 'keuangan', 'kritis', 988895706, 'K01', 'recovery', 'gm', '2026-09-28', [
                ['Daily pipeline report banquet (inquiry–confirmed) dikirim ke GM', 'sales', '2026-09-30', 'selesai', 100],
                ['Tactical promotion untuk tanggal low occupancy Okt 2026', 'fom', '2026-10-05', 'selesai', 100],
                ['Follow up Piala Gubernur & PORPROV sampai confirmed', 'sales', '2026-10-20', 'berjalan', 50],
                ['Evaluasi target banquet Q4 terhadap kondisi permintaan', 'gm', '2026-10-31', 'belum', 0],
            ]],
            ['Lost business Rp192,5 jt (21–27 Sep 2026)', 'Kalah pitching (Gadar Medik: room Rp29 jt + MICE Rp71 jt), bentrok jadwal Malibu Dome dengan event PSI (Ega Fam Gath Rp22,5 jt; Forum Muslimah Ukhuwah Rp20,3 jt + Rp49,7 jt). Puratos membatalkan dan pindah ke Santika Pasir Koja karena plafon Jayagiri rendah.', 'tinjauan', 'weekly_sep', 'pelanggan', 'tinggi', 192500000, 'K20', 'recovery', 'gm', '2026-09-28', [
                ['SOP cek konflik venue & opsi venue alternatif sebelum quotation', 'sales', '2026-10-15', 'berjalan', 60],
                ['Kajian teknis peningkatan plafon / penataan Jayagiri', 'ce', '2026-11-15', 'belum', 0],
                ['Analisis penyebab kalah pitching vs kompetitor', 'sales', '2026-10-10', 'berjalan', 40],
            ]],
            ['Kebocoran sand filter kolam renang', 'Setelah pompa Hayward 2HP terpasang (28 Sep 2026) ditemukan kebocoran pada sand filter.', 'tinjauan', 'weekly_sep', 'proses', 'sedang', null, 'K23', 'facility', 'ce', '2026-09-28', [
                ['Perbaikan kebocoran sand filter & uji tekanan', 'ce', '2026-10-10', 'selesai', 100],
            ]],
            ['Akun Google Business palsu & komentar spam', 'Ada akun palsu yang mengatasnamakan hotel dan fake comment di Google Business; berisiko menyesatkan tamu dan menurunkan rating.', 'pelanggan', 'weekly_sep', 'pelanggan', 'tinggi', null, 'K16', 'brand', 'gm', '2026-09-28', [
                ['Laporkan akun palsu ke Google & verifikasi ulang profil resmi', 'fom', '2026-10-12', 'berjalan', 50],
                ['Pantau & balas ulasan harian (≤ 24 jam)', 'fom', '2026-10-31', 'berjalan', 70],
            ]],
            ['Kamar bintang 4 tanpa air mineral', 'Keluhan tamu Traveloka (skor 6,7): kamar tidak disediakan air mineral; ulasan lain menyinggung sarapan berbayar & bangunan jadul.', 'pelanggan', 'weekly_sep', 'pelanggan', 'sedang', null, 'K17', 'foodcost', 'gm', '2026-09-28', [
                ['Standar 2 botol air mineral per kamar per malam di semua kamar', 'ehk', '2026-10-05', 'selesai', 100],
                ['Proposal depo air minum (Purchasing)', 'purchasing', '2026-10-15', 'berjalan', 60],
            ]],
            ['Penangguhan beban food cost pada data persediaan (Rp667,5 jt)', 'Feb–Mar 2026 dilakukan deferred cost untuk menjaga GOP; Timwas memutuskan beban dibebankan riil dan tidak ada lagi penangguhan.', 'timwas', 'timwas_jun', 'keuangan', 'tinggi', 667500000, 'K10', 'foodcost', 'wilfred', '2026-06-03', [
                ['Pendataan cost yang ditangguhkan vs riil', 'ca', '2026-06-30', 'selesai', 100],
                ['Pembebanan riil di closing Juni & seterusnya', 'ca', '2026-07-10', 'selesai', 100],
            ], 'ditutup'],
            ['Likuiditas lemah & deposit OTA terpakai operasional', 'Aset lancar hanya 45% kewajiban operasional; deposit TA/OTA Rp582,1 jt melebihi saldo bank Rp331,8 jt; kekurangan modal kerja ±Rp930 jt.', 'tinjauan', 'q2', 'keuangan', 'kritis', 930474298, 'K06', 'cash', 'gm', '2026-07-15', [
                ['Proyeksi kas mingguan dipresentasikan setiap Senin', 'ca', '2026-07-31', 'selesai', 100],
                ['Penagihan piutang lama > 60 hari', 'ca', '2026-09-30', 'berjalan', 55],
                ['Buka rekening khusus deposit TA/OTA', 'ca', '2026-09-30', 'berjalan', 20],
                ['Jadwal cicilan PBB 2025 disepakati Bapenda', 'ca', '2026-08-31', 'berjalan', 25],
            ]],
            ['Penutupan rekening lama BJB & BRI belum tuntas', 'Rekening BRI menunggu surat kuasa; BJB tertunda karena 2 lembar cek hilang.', 'timwas', 'timwas_jun', 'proses', 'sedang', null, null, 'cash', 'wilfred', '2026-06-03', [
                ['Surat kuasa penutupan rekening BRI', 'ca', '2026-06-20', 'selesai', 100],
                ['Laporan kehilangan cek & penutupan rekening BJB', 'ca', '2026-08-31', 'berjalan', 30],
            ]],
            ['Analisis penyebab inefisiensi belum disampaikan', 'CEO meminta analisis penyebab inefisiensi di GP (rapat 23 Sep 2026); Timwas meminta hasilnya pada rapat manajemen Oktober.', 'timwas', 'weekly_sep', 'proses', 'sedang', null, null, null, 'wilfred', '2026-10-05', []],
        ];
        foreach ($findings as $f) {
            [$title, $desc, $source, $rev, $persp, $sev, $amount, $kpi, $ini_k, $raiser, $date, $actions] = $f;
            $finding = Finding::create(['title' => $title, 'description' => $desc, 'source' => $source, 'performance_review_id' => $r[$rev]->id ?? null,
                'perspective' => $persp, 'severity' => $sev, 'amount' => $amount, 'kpi_id' => $kpi ? $k[$kpi]->id : null,
                'strategic_initiative_id' => $ini_k ? $ini[$ini_k]->id : null, 'raised_by' => $u[$raiser]->id, 'raised_at' => $date, 'status' => 'terbuka']);
            foreach ($actions as [$at, $owner, $due, $st, $prog]) {
                CorrectiveAction::create(['finding_id' => $finding->id, 'title' => $at, 'owner_id' => $u[$owner]->id, 'due_date' => $due, 'status' => $st, 'progress' => $prog,
                    'result_note' => $st === 'selesai' ? 'Selesai — bukti di laporan departemen.' : null]);
            }
            $finding->refresh()->syncStatus();
            if (($f[12] ?? null) === 'ditutup') {
                $finding->forceFill(['status' => 'ditutup', 'closed_by' => $u['gm']->id, 'closed_at' => '2026-07-15 16:00:00',
                    'closure_note' => 'Ditutup pada Tinjauan Keuangan Q2 setelah pembebanan riil diverifikasi (dicatat saat migrasi data).'])->saveQuietly();
            }
        }

        return $ini;
    }
}
