<?php

namespace Database\Seeders\Gpch;

use App\Models\Competitor;
use App\Models\EnvironmentScan;
use App\Models\IndustryForce;
use App\Models\MarketAnalysis;
use App\Models\PestelAnalysis;
use App\Models\Regulation;
use App\Models\Stakeholder;
use App\Models\StrategicIssue;
use App\Models\SwotItem;
use App\Models\TowsStrategy;

class EcosystemSeeder
{
    public function seed(array $u): void
    {
        // ---------------- Pemindaian lingkungan
        foreach ([
            ['Assessment awal operasional & fasilitas', '2024-12-08', 'internal', 'The Grand Pasundan: Sebuah Assessment Awal — I.G. Wiwin Suyasa (Visi Perencana Indonesia), 7–8 Des 2024',
                'Fasilitas mulai kusam (marmer lobby, toilet lobby, karpet & screen ruang rapat robek, dapur & pastry tidak layak, kolam tanpa style). SDM: motivasi rendah (mayoritas karyawan tetap usia 50+), teknisi hanya 4 orang, belum ada program pelatihan, gaji & service charge sering terlambat (service sempat tertunda 5 bulan). Keuangan: tidak ada Balance Sheet, PnL tidak selalu ada tiap bulan. Keunggulan: ukuran kamar luas, lahan luas, executive floor & lounge berpotensi.',
                'Prioritas perbaikan bertahap: dapur & pastry (epoxy 3–5 mm), ruang rapat (karpet, screen, smartboard co-branding), lobby & toilet. Wajib tiga laporan keuangan bulanan. Upgrade PMS (VHP/OmniH) yang terhubung OTA.'],
            ['Konsep Kerja Manajemen Baru 2025 — Hotel Serbaguna Berbasis Pengalaman', '2025-03-13', 'eksternal', 'Konsep Kerja GPCH 2025 — GM Fery Ferdiansyah & Pengawas Umum Sonny L. Halim',
                'Pasar bergeser ke pengalaman yang fleksibel & personal; persaingan hotel bertema; MICE pemerintah berkurang akibat pemangkasan anggaran. Peluang coworking/WFH, family staycation, wedding experience, komunitas.',
                'Konsep hotel serbaguna & storytelling Sunda, pemasaran digital (IG, TikTok, SEO, influencer, kode promo GRANDPASUNDAN10), kerja sama TA/EO Jateng–Jatim, QRIS di semua outlet, SDM multitasking, opsi outsourcing supporting department.'],
            ['Implementasi VHP Cloud (PMS & back office)', '2025-04-04', 'internal', 'Weekly Implementation Checklist VHP — Mukti & Yohanes (Mar–Apr 2025)',
                'Setup FO, POS (4 outlet), Night Audit, Income Audit, AR, Banquet selesai Mar–Apr 2025. Tertunda di pihak hotel: saldo awal, aging AR/AP, supplier, artikel inventory, store, cost center, keycard, PABX, channel manager. Tidak ada modul fixed asset & engineering.',
                'Lengkapi data master back office agar laporan BS & PnL bisa dihasilkan dari sistem; manfaatkan dashboard VHP Mobile.'],
            ['Review keuangan Juni 2026 — likuiditas', '2026-06-30', 'internal', 'Analisis Singkat Keuangan GPCH — Juni 2026',
                'Penerimaan Rp2.401.524.265 vs pengeluaran Rp2.379.705.393 (surplus Rp21,8 jt = 0,91%). Saldo bank Rp331,8 jt; aset lancar Rp754,9 jt hanya 45% dari kewajiban operasional Rp1.685,4 jt. Deposit TA/OTA Rp582,1 jt melebihi saldo bank. Pembelian F&B Rp464,4 jt (52% pendapatan F&B). Utang PBB 2025 Rp339,3 jt; utang CEO jangka panjang Rp30,91 M.',
                'Proyeksi kas mingguan, percepatan penagihan piutang, kendali food cost, jaga deposit OTA, jadwalkan pemasok & PBB, restrukturisasi utang CEO.'],
            ['Benchmark kompetitor & pasar — September 2026', '2026-09-28', 'eksternal', 'GM Weekly Report 21–27 Sep 2026',
                'GPCH peringkat 3 dari 5 dalam competitive set: okupansi 55,33%, ARR Rp330.913, RGI 0,92, MPI 0,96, ARI 0,96. Santika Pasir Koja memimpin RevPAR (RGI 1,35). Rating Booking.com GPCH tertinggi (9,3) namun Google 4,4 dan Tiket.com 4,1. Lost business Rp192,5 jt dalam sepekan karena kalah pitching dan bentrok jadwal Malibu Dome.',
                'Revenue recovery: tactical promotion pada tanggal low-demand, jaga ADR, push corporate/government/group/OTA; banquet sebagai prioritas utama.'],
            ['Tren event & pameran: kendaraan listrik, olahraga daerah', '2026-09-23', 'eksternal', 'MoM Rapat Manajemen 23 Sep 2026',
                'Pameran mobil listrik sedang tren; prospek PORPROV (Nov, est. Rp45 jt) & Piala Gubernur (Okt, est. Rp153,8 jt) dari pendekatan DISPORA/KONI Jabar; Malibu Dome dipromosikan sebagai venue exhibition (Tribun Jabar).',
                'Sales mencari peluang event yang sedang booming; HOD ikut mencari peluang event.'],
        ] as [$title, $date, $scope, $source, $summary, $impl]) {
            EnvironmentScan::create(compact('title', 'scope', 'source', 'summary') + ['scan_date' => $date, 'implications' => $impl, 'status' => 'aktif', 'created_by' => $u['koordinator']->id]);
        }

        // ---------------- PESTEL
        foreach ([
            ['politik', 'Efisiensi anggaran belanja pemerintah', 'Pemangkasan anggaran perjalanan dinas & rapat instansi menurunkan MICE pemerintahan yang selama ini menjadi tumpuan banquet GPCH.', 'ancaman', 5, 4, 'naik', 'Diversifikasi ke korporasi, sosial/wedding, komunitas, pendidikan; paket meeting fleksibel.', 'Konsep Kerja 2025'],
            ['politik', 'Agenda event olahraga & kebudayaan daerah', 'PORPROV Jabar (Nov 2026) dan Piala Gubernur (Okt 2026); kegiatan Disbudpar & Dispora Kota Bandung rutin memakai hotel.', 'peluang', 3, 4, 'naik', 'Pendekatan DISPORA/KONI se-Jabar; paket akomodasi atlet & ofisial.', 'GM Weekly Report Sep 2026'],
            ['ekonomi', 'Kenaikan harga energi', 'Solar Rp21.300/L (27 Sep 2026); LPG 50 kg naik menjadi Rp1.070.000/tabung dan 12 kg Rp235.000 (16 Sep 2026). Konsumsi energi Sep ±Rp213,3 jt.', 'ancaman', 4, 5, 'naik', 'Konversi LPG→CNG, lampu LED, monitoring energi mingguan.', 'Engineering Energy Report Sep 2026'],
            ['ekonomi', 'Biaya tenaga kerja & bahan baku terus naik', 'UMK, listrik, bahan bakar, air dan bahan F&B cenderung naik sementara harga kamar stagnan.', 'ancaman', 4, 5, 'naik', 'Kendali food cost, struktur SDM multitasking, revenue per available room.', 'Assessment Awal Des 2024'],
            ['ekonomi', 'Permintaan staycation keluarga & akhir pekan', 'Kolam renang besar dan kamar luas diminati keluarga (ulasan Google Sep 2026); healthy club & breakfast melampaui budget.', 'peluang', 3, 4, 'naik', 'Paket family staycation, cafetaria weekend, live music.', 'GM Weekly Report Sep 2026'],
            ['sosial', 'Wisata pengalaman & budaya lokal', 'Tamu mencari pengalaman autentik: kuliner Sunda, cerita, desain lokal ("Staycation budaya di Bandung").', 'peluang', 4, 4, 'naik', 'Pasundan Experience: welcome ritual, menu bercerita, ornamen Sunda, kelas memasak.', 'Konsep Kerja 2025'],
            ['sosial', 'Pasar wedding & acara sosial Bandung', 'Permintaan venue wedding & gathering keluarga tetap tinggi; pameran wedding (Heritage Wedding Bride Expo, Jan 2027).', 'peluang', 4, 3, 'stabil', 'Paket wedding Malibu Dome & outdoor; ikut wedding expo.', 'GM Weekly Report Sep 2026'],
            ['teknologi', 'Dominasi OTA & metasearch', 'Sebagian besar reservasi individu lewat Traveloka, Agoda, Tiket.com, Booking.com, Expedia, Trip.com; komisi menekan ARR.', 'ancaman', 4, 5, 'naik', 'Aktifkan metasearch Google, booking engine, promo kode di website, WA booking.', 'GM Weekly Report Sep 2026'],
            ['teknologi', 'Digitalisasi pembayaran & PMS cloud', 'QRIS, VHP Cloud & dashboard mobile memungkinkan rekonsiliasi otomatis dan data real-time.', 'peluang', 3, 4, 'naik', 'QRIS di semua outlet; manfaatkan dashboard VHP; Arah GPCH untuk KPI.', 'Konsep Kerja 2025'],
            ['teknologi', 'Tren kendaraan listrik', 'Pameran mobil listrik sedang diminati; kebutuhan charger EV di hotel.', 'peluang', 2, 3, 'naik', 'Instalasi jalur kabel charger mobil listrik di basement; tawarkan Malibu Dome untuk pameran otomotif.', 'MoM 23 Sep 2026'],
            ['lingkungan', 'Pengelolaan limbah & air tanah', 'Pajak air tanah (closing tiap tanggal 10), STP, TPS sampah yang meluap saat event besar dengan katering luar.', 'ancaman', 3, 4, 'stabil', 'Pemanfaatan limbah STP (vendor Jayawiratama), area khusus katering luar.', 'Engineering Report Sep 2026; Assessment Des 2024'],
            ['hukum', 'Kepatuhan royalti hak cipta musik', 'Sosialisasi Kanwil Kementerian Hukum Jabar tentang kepatuhan hak cipta musik di hotel (1 Okt 2026); berlaku untuk musik lobby, live music & karaoke.', 'ancaman', 3, 4, 'naik', 'Inventarisasi pemakaian musik; lisensi/royalti melalui LMKN.', 'GM Weekly Report Sep 2026 (rencana HR)'],
            ['hukum', 'Kewajiban PBB & pajak daerah', 'Utang PBB 2025 Rp339,3 jt belum diselesaikan; risiko denda & kepatuhan.', 'ancaman', 4, 5, 'stabil', 'Jadwal cicilan PBB, komunikasi dengan Bapenda.', 'Analisis Keuangan Juni 2026'],
            ['hukum', 'Penempatan tenaga kerja yang aman & legal', 'Transformasi sistem penempatan tenaga kerja (Disnaker Jabar); komposisi GPCH: PKWT 34, daily worker 38, trainee 17.', 'ancaman', 3, 3, 'naik', 'Tinjau status daily worker & casual; administrasi HRM lengkap.', 'GM Weekly Report Sep 2026'],
        ] as [$factor, $title, $desc, $type, $impact, $like, $trend, $resp, $src]) {
            PestelAnalysis::create(['factor' => $factor, 'title' => $title, 'description' => $desc, 'impact_type' => $type, 'impact_level' => $impact, 'likelihood' => $like, 'trend' => $trend, 'response' => $resp, 'source' => $src]);
        }

        // ---------------- Lima kekuatan industri
        foreach ([
            ['persaingan', 'Persaingan ketat di koridor Pasir Koja – Bandung Barat', 'Santika Pasir Koja, Harris Festival Citylink, Horison Bandung, Grand Asrilia bersaing di segmen MICE & korporasi dengan produk lebih baru.', 5, 'Diferensiasi pengalaman Pasundan & kapasitas Malibu Dome; jaga ARR.'],
            ['kekuatan_pembeli', 'Instansi & OTA menekan harga', 'Pembeli grup/instansi membandingkan harga lintas hotel saat pitching; OTA mengendalikan visibilitas.', 4, 'Paket bernilai tambah, bukan diskon menyeluruh; tingkatkan direct booking.'],
            ['pendatang_baru', 'Hotel & venue baru di Bandung', 'Hotel baru dan venue konvensi alternatif terus bermunculan; hambatan masuk segmen budget rendah.', 3, 'Perkuat loyalitas akun korporat & pemerintah.'],
            ['produk_pengganti', 'Rapat daring & venue non-hotel', 'Kegiatan dialihkan menjadi online (mis. MES Sep 2026); gedung serbaguna, kafe & coworking sebagai pengganti.', 3, 'Paket hybrid meeting, coworking/WFH, komunitas.'],
            ['kekuatan_pemasok', 'Pemasok F&B, energi & PMS', 'Harga bahan pokok & energi naik; ketergantungan pada vendor PMS (VHP) dan vendor lift.', 3, 'Kontrak pemasok, hunting harga pasar DML, ticketing vendor terdokumentasi.'],
        ] as [$force, $title, $desc, $int, $impl]) {
            IndustryForce::create(['force' => $force, 'title' => $title, 'description' => $desc, 'intensity' => $int, 'implication' => $impl]);
        }

        // ---------------- Pasar & pelanggan (porsi = estimasi pendapatan kamar+MICE, PROYEKSI)
        foreach ([
            ['Instansi pemerintah (MICE pemerintahan)', 'MICE', 'DISPORA, DISBUDPAR, DISNAKER, BPJS, SATPOL PP Kota/Kab. Bandung — halfday & fullboard meeting.', 24, 'turun', true, 'Paket meeting sesuai SBM, administrasi pembayaran rapi, ketersediaan ruang besar.', 'Jaga akun, paket fullboard, tagih tepat waktu.'],
            ['Korporasi', 'Korporasi', 'Perusahaan farmasi, perbankan, distributor (mis. Anugrah Pharmindo Lestari, Puratos) — meeting, training, gathering.', 14, 'naik', true, 'Fasilitas ruang rapat layak (plafon, AV), harga fleksibel, layanan cepat.', 'Corporate rate, early booking, paket meeting per pax.'],
            ['Grup & travel agent / tour', 'Grup', 'WITA Tour, Shiddiq Tour, Mampuh Travel, NRA Travel, Smart Umroh — rombongan wisata & manasik.', 9, 'naik', true, 'Harga grup, makan rombongan, parkir bus.', 'Kontrak TA Jateng–Jatim, komisi khusus.'],
            ['Online Travel Agent (individu)', 'OTA', 'Traveloka, Agoda, Tiket.com, Booking.com, Expedia, Trip.com.', 27, 'naik', true, 'Harga kompetitif, ulasan baik, foto terbaru.', 'Campaign OTA (10.10, birthday sale), early bird, last minute deal.'],
            ['Direct (walk-in, website, WhatsApp)', 'Direct', 'Promo WA blast (Septembersama 212 RN), walk-in 15%, website & booking engine.', 11, 'naik', true, 'Respons cepat, promo eksklusif, database tamu repeater.', 'WA blast bulanan, program ulang tahun, metasearch Google.'],
            ['Wedding & acara sosial', 'Sosial', 'Pernikahan, reuni, gathering keluarga, komunitas & keagamaan (GMAHK, IPARI, Forum Muslimah).', 9, 'stabil', true, 'Venue indoor/outdoor, dekorasi, katering, paket all-in.', 'Paket wedding, wedding expo, kerja sama WO.'],
            ['Pendidikan & long stay group', 'Long stay', 'Universitas Teknologi Bandung (UTB) group longstay, PKL, institusi pendidikan.', 6, 'stabil', true, 'Harga long stay, makan, laundry.', 'Pertahankan kontrak UTB; tawarkan ke kampus lain.'],
            ['Leisure keluarga & staycation', 'Leisure', 'Keluarga akhir pekan dan liburan sekolah: kolam renang, kids corner, family karaoke.', 0, 'naik', true, 'Kolam bersih & bergaya, aktivitas anak, kuliner.', 'Paket family staycation & Pasundan Experience (porsi tercakup di OTA/Direct).'],
            ['Digital nomad / Work From Hotel', 'WFH', 'Pekerja jarak jauh membutuhkan coworking & internet cepat (keluhan Wi-Fi lambat di ulasan).', 0, 'naik', false, 'Wi-Fi cepat, meja kerja & pencahayaan kamar.', 'Paket WFH setelah Wi-Fi & pencahayaan kamar diperbaiki.'],
        ] as [$seg, $grp, $desc, $share, $growth, $target, $needs, $strat]) {
            MarketAnalysis::create(['segment' => $seg, 'segment_group' => $grp, 'description' => $desc, 'share_percent' => $share ?: null, 'growth' => $growth, 'is_target' => $target, 'needs' => $needs, 'strategy' => $strat,
                'source' => $share ? 'PROYEKSI porsi pendapatan Jan–Sep 2026 — konfirmasi Sales & Chief Accountant (laporan segmen VHP)' : 'Kualitatif']);
        }

        // ---------------- Pesaing (GM Weekly Report Sep 2026)
        foreach ([
            ['Grand Pasundan Convention Hotel', 'Bintang 4', 164, 3, 4733, 2619, 55.33, 330913, 183110, 0.92, 0.96, 0.96, 4.4, 4.4, 8.3, 9.3, 4.1, true, 'Malibu Dome 1.200 pax, kamar luas, lahan & parkir luas, kolam besar.', 'Bangunan terkesan jadul, ruang rapat & dapur perlu revitalisasi, ARR di bawah pesaing.'],
            ['Harris Hotel Festival Citylink', 'Bintang 4', null, 2, 5020, 2697, 53.72, 392520, 210880, 1.19, 1.06, 1.12, 4.6, 4.6, 8.4, 8.3, 4.5, false, 'Terhubung mal Festival Citylink, brand jaringan nasional.', 'Kapasitas ballroom lebih kecil dari Malibu Dome.'],
            ['Santika Hotel Pasir Koja', 'Bintang 3', null, 1, 2520, 1672, 66.34, 360517, 239200, 1.35, 1.31, 1.03, 4.7, 4.9, 8.6, 8.3, 4.5, false, 'Okupansi & RevPAR tertinggi, rating Google 4,7; memenangkan event yang pindah dari GPCH (Puratos).', 'Jumlah kamar lebih sedikit.'],
            ['Horison Hotel Bandung', 'Bintang 4', null, 4, 5656, 2916, 51.55, 377955, 194850, 1.10, 1.01, 1.08, 4.2, 4.4, 7.9, 7.2, 4.0, false, 'Jaringan Horison, aktif di reuni & instansi (Reuni BNI, Kowad).', 'Rating OTA lebih rendah.'],
            ['Grand Asrilia Hotel', 'Bintang 4', null, 5, 5860, 2450, 41.80, 322078, 134650, 0.76, 0.82, 0.92, 4.3, 3.0, 8.3, null, 4.2, false, 'Convention & exhibition, dekat pusat kota.', 'Okupansi & RevPAR terendah di competitive set.'],
        ] as [$name, $cat, $rooms, $rank, $avail, $sold, $occ, $arr, $revpar, $rgi, $mpi, $ari, $g, $ta, $tv, $bk, $tk, $self, $str, $weak]) {
            Competitor::create(['name' => $name, 'category' => $cat, 'room_count' => $rooms, 'rank' => $rank, 'data_period' => 'Sep 2026 (GM Weekly Report)',
                'room_available' => $avail, 'room_sold' => $sold, 'occupancy' => $occ, 'arr' => $arr, 'revpar' => $revpar, 'rgi' => $rgi, 'mpi' => $mpi, 'ari' => $ari,
                'rating_google' => $g, 'rating_tripadvisor' => $ta, 'rating_traveloka' => $tv, 'rating_booking' => $bk, 'rating_tiket' => $tk,
                'is_self' => $self, 'strengths' => $str, 'weaknesses' => $weak]);
        }

        // ---------------- Regulasi
        foreach ([
            ['Pajak Bumi dan Bangunan (PBB-P2) 2025', 'Pemerintah Kota Bandung (Bapenda)', null, 'Pajak', '2025-01-01', 'Kewajiban PBB tahun 2025 sebesar Rp339.306.820 belum dilunasi per Juni 2026.', 'Denda & risiko kepatuhan; membebani arus kas.', 'belum', 'ca', '2026-12-31'],
            ['Pajak Barang dan Jasa Tertentu (PBJT) jasa perhotelan & makanan-minuman', 'Pemerintah Kota Bandung', 'UU No. 1 Tahun 2022 (HKPD) & Perda Kota Bandung', 'Pajak', null, 'Pajak daerah atas jasa perhotelan dan makanan/minuman yang dipungut dari tamu dan disetor bulanan.', 'Harus tercermin benar di VHP (tax & service) dan disetor tepat waktu.', 'patuh', 'ca', null],
            ['Pajak air tanah', 'Pemerintah Provinsi/Kota (Bapenda)', null, 'Pajak', null, 'Pemakaian sumur 1 & 2 (±2.215 m³/bulan); closing setiap tanggal 10.', 'Biaya energi/utilitas; pencatatan meter wajib rutin.', 'patuh', 'ce', null],
            ['Royalti hak cipta lagu dan/atau musik', 'Kementerian Hukum — LMKN', 'PP No. 56 Tahun 2021', 'Hak cipta', null, 'Penggunaan musik di area publik hotel, live music, dan karaoke secara komersial wajib membayar royalti.', 'Sosialisasi Kanwil Jabar 1 Okt 2026; risiko teguran/tuntutan.', 'dipantau', 'hrm', '2026-12-31'],
            ['Perjanjian kerja waktu tertentu (PKWT) & alih daya', 'Kementerian Ketenagakerjaan / Disnaker Jabar', 'PP No. 35 Tahun 2021', 'Ketenagakerjaan', null, 'Ketentuan PKWT, alih daya, waktu kerja; komposisi karyawan GPCH banyak daily worker & trainee.', 'Status casual/daily worker perlu ditata; administrasi HRM.', 'sebagian', 'hrm', '2026-12-31'],
            ['BPJS Ketenagakerjaan & Kesehatan', 'BPJS', null, 'Ketenagakerjaan', null, 'Kepesertaan & iuran BPJS seluruh karyawan; Notulen 3 Jun 2026: payroll, service & BPJS dibayarkan Manajemen GPCH.', 'Keterlambatan berisiko denda & menurunkan motivasi.', 'patuh', 'hrm', null],
            ['Jaminan produk halal F&B', 'BPJPH Kementerian Agama', 'UU No. 33 Tahun 2014 jo. PP No. 39 Tahun 2021', 'F&B', null, 'Kewajiban sertifikasi halal produk makanan & minuman yang dijual.', 'Penting untuk segmen pemerintah, umroh & keluarga muslim.', 'dipantau', 'fbm', null],
            ['K3 elevator', 'Kementerian Ketenagakerjaan', 'Permenaker No. 6 Tahun 2017', 'Keselamatan', null, 'Pemeriksaan & pengujian berkala elevator; penggantian panel lift 1 (Sep–Okt 2026).', 'Lift tamu & karyawan wajib laik operasi.', 'sebagian', 'ce', '2026-11-30'],
            ['Baku mutu air limbah domestik', 'Kementerian Lingkungan Hidup', 'Permen LHK No. P.68 Tahun 2016', 'Lingkungan', null, 'Pengolahan air limbah (STP) harus memenuhi baku mutu sebelum dibuang.', 'Rencana pemanfaatan limbah STP dengan vendor.', 'dipantau', 'ce', null],
        ] as [$title, $issuer, $ref, $cat, $eff, $desc, $impact, $status, $owner, $due]) {
            Regulation::create(['title' => $title, 'issuer' => $issuer, 'reference_no' => $ref, 'category' => $cat, 'effective_date' => $eff, 'description' => $desc, 'impact' => $impact, 'compliance_status' => $status, 'owner_id' => $u[$owner]->id, 'due_date' => $due]);
        }

        // ---------------- Pemangku kepentingan
        $sh = [];
        foreach ([
            'pemilik' => ['Pemilik (Bapak Wimpy)', 'internal', 'Pemilik', 5, 5, 'Hasil: profit, nilai properti, nama baik Grand Pasundan.', 'Laporan bulanan ringkas, keputusan investasi bertahap.', 'Bapak Wimpy'],
            'timwas' => ['Tim Pengawas (Ketua: Bapak Wilfred)', 'internal', 'Pengawas', 5, 5, 'Disiplin biaya, laporan keuangan real (tanpa penangguhan beban), tindak lanjut keputusan.', 'Laporan Arah GPCH setelah rapat manajemen; catatan pengawasan.', 'Bapak Wilfred'],
            'ceo' => ['CEO — pemberi pinjaman jangka panjang', 'internal', 'Kreditur', 4, 5, 'Kepastian pengembalian utang Rp30,91 M; efisiensi (minta analisis penyebab inefisiensi).', 'Usulan restrukturisasi (perpanjang tenor, subordinasi, konversi modal).', null],
            'karyawan' => ['Karyawan (PKWT, daily worker, trainee)', 'internal', 'SDM', 5, 3, 'Gaji & service charge tepat waktu, pelatihan, kejelasan aturan.', 'Komunikasi dua arah, forum bulanan, evaluasi kinerja.', 'HR Manager'],
            'korporat' => ['Tamu korporat & instansi pemerintah', 'eksternal', 'Pelanggan', 5, 4, 'Ruang rapat layak, harga sesuai, layanan cepat, administrasi rapi.', 'Sales call, account management, paket meeting.', 'Sales & Marketing'],
            'ota' => ['OTA (Traveloka, Agoda, Tiket.com, Booking.com, Trip.com)', 'eksternal', 'Mitra distribusi', 4, 4, 'Paritas harga, ketersediaan, respons ulasan.', 'Business review berkala, campaign bersama.', 'FO / E-commerce'],
            'ta_eo' => ['Travel agent & event organizer', 'eksternal', 'Mitra penjualan', 4, 3, 'Komisi, harga grup, kemudahan booking.', 'Kontrak & table top Jateng–Jatim.', 'Sales & Marketing'],
            'vhp' => ['VHP (vendor PMS cloud)', 'eksternal', 'Vendor', 3, 3, 'Data master lengkap dari hotel, tiket permintaan jelas (#181ADD).', 'Daftar permintaan & timeline PIC.', 'EDP'],
            'pemasok' => ['Pemasok F&B & material', 'eksternal', 'Pemasok', 3, 4, 'Pembayaran tepat waktu (utang usaha Rp580,9 jt per Jun 2026).', 'Jadwal pembayaran berdasarkan prioritas & jatuh tempo.', 'Purchasing'],
            'pemkot' => ['Pemkot Bandung (Bapenda, Disbudpar, Dispora)', 'eksternal', 'Regulator & pelanggan', 4, 4, 'Kepatuhan pajak (PBB, PBJT), dukungan event kota.', 'Jadwal cicilan PBB; kemitraan event.', 'Chief Accountant / Sales'],
            'warga' => ['Masyarakat Kec. Bojongloa Kaler', 'eksternal', 'Komunitas', 2, 3, 'Kontribusi sosial (HUT Kota Bandung, Jumat berkah), lingkungan bersih.', 'CSR, flyering kerja sama kecamatan.', 'HR Manager'],
            'media' => ['Media (Tribun Jabar, radio)', 'eksternal', 'Media', 2, 3, 'Konten menarik, barter exposure.', 'Rilis venue exhibition, video company profile.', 'Sales & Marketing'],
            'bank' => ['Bank (BJB, BRI)', 'eksternal', 'Keuangan', 3, 3, 'Penutupan rekening lama tertib (cek hilang).', 'Surat kuasa & laporan kehilangan cek.', 'Chief Accountant'],
        ] as $key => [$name, $type, $cat, $infl, $int, $exp, $strat, $cp]) {
            $sh[$key] = Stakeholder::create(['name' => $name, 'type' => $type, 'category' => $cat, 'influence' => $infl, 'interest' => $int, 'expectations' => $exp, 'engagement_strategy' => $strat, 'contact_person' => $cp]);
        }

        // ---------------- 12 isu strategis
        $issues = [];
        foreach ([
            'rev' => ['Pendapatan jauh di bawah anggaran', 'Total revenue MTD 21–27 Sep 2026 Rp1,41 M = 51,6% budget (shortfall Rp988,9 jt); turun 17,6% dibanding bulan lalu.', 'keuangan', 5, 5, 'GM Weekly Report Sep 2026', 'gm', ['pemilik', 'timwas', 'korporat']],
            'banquet' => ['Banquet/MICE tertinggal & ketergantungan pada instansi pemerintah', 'Banquet MTD Rp430,7 jt vs budget Rp1,18 M (shortfall Rp681,95 jt); MICE pemerintah turun karena efisiensi anggaran.', 'pelanggan', 5, 5, 'MoM 23 Sep 2026', 'sales', ['korporat', 'ta_eo', 'pemkot']],
            'cash' => ['Likuiditas lemah & deposit OTA terpakai operasional', 'Aset lancar hanya 45% kewajiban operasional; deposit TA/OTA Rp582 jt > saldo bank Rp332 jt; surplus kas hanya 0,91%.', 'keuangan', 5, 5, 'Analisis Keuangan Juni 2026', 'ca', ['pemilik', 'timwas', 'pemasok', 'ota']],
            'debt' => ['Utang CEO Rp30,91 M & utang PBB 2025 belum terjadwal', 'Utang jangka panjang CEO belum jelas bunga, tenor & jadwal; PBB 2025 Rp339,3 jt tertunggak.', 'keuangan', 4, 5, 'Analisis Keuangan Juni 2026', 'ca', ['ceo', 'pemilik', 'pemkot']],
            'foodcost' => ['Food cost & pembelian F&B tinggi', 'Pembelian F&B 52% dari pendapatan F&B (Jun 2026); praktik penangguhan beban (deferred cost) stok gudang Rp667,5 jt dihentikan Timwas.', 'proses', 4, 4, 'Notulen 3 Jun 2026; Analisis Keuangan Jun 2026', 'fbm', ['timwas', 'pemasok']],
            'facility' => ['Kondisi fasilitas menurun', 'Dapur & pastry tidak layak, karpet/screen ruang rapat lusuh, plafon Jayagiri rendah (event pindah ke Santika), kebocoran sand filter kolam, panel lift.', 'proses', 4, 5, 'Assessment Des 2024; GM Weekly Report Sep 2026', 'ce', ['korporat', 'pemilik']],
            'arr' => ['ARR di bawah kompetitor', 'ARR GPCH Rp330.913 (ARI 0,96) vs Harris Rp392.520 & Horison Rp377.955; diskon berlebihan menekan ADR (Sep MTD Rp334.547 vs budget Rp398.860).', 'pelanggan', 4, 4, 'GM Weekly Report Sep 2026', 'sales', ['ota', 'korporat']],
            'reputation' => ['Reputasi digital & pengalaman tamu', 'Akun Google Business palsu & komentar spam; keluhan air mineral, bangunan jadul, sarapan berbayar; Wi-Fi lambat.', 'pelanggan', 4, 4, 'GM Weekly Report Sep 2026', 'fom', ['ota', 'media']],
            'reporting' => ['Pelaporan keuangan & pemanfaatan VHP belum optimal', 'Neraca belum tersedia (assessment 2024), modul back office VHP menunggu data hotel, menu dashboard & approval PR belum aktif. "Sistem adalah alat operasional, bukan laporan."', 'proses', 4, 4, 'MoM 23 Sep 2026; Checklist VHP 2025', 'ca', ['vhp', 'timwas']],
            'hr' => ['Motivasi SDM, kesejahteraan & kompetensi', 'Riwayat keterlambatan gaji & service charge, pelatihan belum terstruktur, teknisi kurang, CE & EHK masih kosong/Plt.', 'sdm', 4, 4, 'Assessment Des 2024; GM Weekly Report Sep 2026', 'hrm', ['karyawan']],
            'energy' => ['Kenaikan biaya energi', 'Kenaikan harga LPG & solar; konsumsi listrik ±88.758 kWh/bulan.', 'keuangan', 3, 4, 'Engineering Energy Report Sep 2026', 'ce', ['pemasok']],
            'leadership' => ['Pergantian GM & kesinambungan kepemimpinan', 'GM baru (Ibu Vivera) bergabung 1 Okt 2026; risiko putusnya tindak lanjut keputusan rapat ("jangan duduk bersepakat tapi action tidak bersepakat").', 'sdm', 3, 4, 'GM Weekly Report Sep 2026 (rencana HR); MoM 23 Sep 2026', 'gm', ['timwas', 'karyawan']],
        ] as $key => [$title, $desc, $persp, $urg, $imp, $src, $owner, $stks]) {
            $issues[$key] = StrategicIssue::create(['title' => $title, 'description' => $desc, 'perspective' => $persp, 'urgency' => $urg, 'impact' => $imp, 'status' => 'ditangani', 'source' => $src, 'owner_id' => $u[$owner]->id]);
            $issues[$key]->stakeholders()->sync(collect($stks)->map(fn ($s) => $sh[$s]->id));
        }

        // ---------------- SWOT
        $sort = 0;
        foreach ([
            ['S', 'Malibu Dome 1.152 m² berkapasitas 1.200 pax + 13 ruang rapat', 'Kapasitas convention terbesar di koridor Bandung barat; event PSI 1.200 pax (Sep 2026).', 0.15, 4],
            ['S', 'Ukuran kamar luas & 7 suite termasuk President & 3-Bedroom Pasundan Suite', 'Keunggulan yang tak terbantahkan (assessment 2024).', 0.10, 4],
            ['S', 'Lahan luas, parkir ±200 kendaraan, kolam renang besar', 'Cocok untuk keluarga, rombongan bus, dan event besar.', 0.10, 3],
            ['S', 'Rating Booking.com 9,3 dan pelayanan resepsionis ramah', 'Ulasan Sep 2026 memuji kebersihan & keramahan.', 0.05, 3],
            ['S', 'Breakfast & healthy club di atas budget', 'Breakfast Rp180 jt (165% budget), healthy club 426% budget MTD Sep 2026.', 0.05, 3],
            ['W', 'Fasilitas & interior menua', 'Dapur, ruang rapat, toilet lobby, kolam tanpa style, kesan "jadul".', 0.12, 2],
            ['W', 'Likuiditas tipis & beban utang besar', 'Surplus kas 0,91%, deposit OTA terpakai, utang CEO Rp30,91 M.', 0.12, 1],
            ['W', 'Food cost tinggi & disiplin persediaan lemah', 'Pembelian F&B 52% pendapatan F&B; praktik penangguhan beban.', 0.08, 2],
            ['W', 'Outlet F&B (coffee shop, room service, lounge) jauh di bawah target', 'Coffee shop 28% budget, room service 20%, lounge 24% (MTD Sep 2026).', 0.08, 2],
            ['W', 'Pelaporan & sistem belum optimal; SDM belum terlatih', 'Neraca belum rutin, modul VHP belum lengkap, pelatihan ad hoc.', 0.10, 2],
            ['O', 'Event olahraga & kebudayaan daerah', 'PORPROV & Piala Gubernur; Disbudpar/Dispora rutin.', 0.10, 3],
            ['O', 'Tren staycation budaya & keluarga', 'Pasundan Experience, kuliner Sunda (Nasi Timbel Empal, nampan liwet).', 0.10, 3],
            ['O', 'Pasar wedding & exhibition (mobil listrik, expo)', 'Malibu Dome ideal untuk pameran; wedding expo 2027.', 0.10, 3],
            ['O', 'Kemitraan TA/EO Jawa Tengah & Jawa Timur', 'Table top Jogja, ASITA travel mart.', 0.05, 2],
            ['T', 'Efisiensi anggaran pemerintah', 'MICE pemerintah dibatalkan/dialihkan online.', 0.15, 2],
            ['T', 'Kompetitor lebih baru & agresif', 'Santika Pasir Koja RGI 1,35; Harris ARR Rp392 rb.', 0.15, 2],
            ['T', 'Kenaikan biaya energi & bahan baku', 'LPG, solar, listrik naik.', 0.10, 2],
            ['T', 'Serangan reputasi digital', 'Akun Google palsu, ulasan spam.', 0.05, 3],
        ] as [$type, $title, $desc, $w, $r]) {
            SwotItem::create(['type' => $type, 'title' => $title, 'description' => $desc, 'weight' => $w, 'rating' => $r, 'sort' => ++$sort, 'source' => 'Analisis manajemen Sep 2026']);
        }

        // ---------------- TOWS
        foreach ([
            ['SO', 'Jual Malibu Dome untuk event olahraga, exhibition & wedding besar', 'Gunakan kapasitas 1.200 pax untuk PORPROV, Piala Gubernur, pameran mobil listrik, wedding expo.', 5, ['banquet', 'rev']],
            ['SO', 'Paket "Pasundan Experience" untuk keluarga & staycation budaya', 'Kamar luas + kolam + kuliner Sunda + kids corner + Pustaka Pasundan.', 4, ['rev', 'arr']],
            ['WO', 'Revitalisasi bertahap berbasis prioritas pendapatan', 'Ruang rapat (karpet, screen, plafon Jayagiri) & dapur lebih dulu agar tidak kehilangan event.', 4, ['facility', 'banquet']],
            ['WO', 'Disiplin food cost lewat standard recipe & DML', 'Input standard recipe di VHP, hunting harga pasar, stop deferred cost.', 4, ['foodcost', 'reporting']],
            ['ST', 'Tactical pricing & revenue management harian', 'Promo hanya pada tanggal low-demand, jaga ADR, review pickup harian.', 5, ['arr', 'rev']],
            ['ST', 'Diversifikasi dari MICE pemerintah ke korporasi, sosial & TA', 'Daily pipeline report, sales call, kontrak TA/EO.', 5, ['banquet']],
            ['WT', 'Program penyehatan arus kas & restrukturisasi kewajiban', 'Proyeksi kas mingguan, penagihan piutang, rekening deposit OTA terpisah, cicilan PBB, restrukturisasi utang CEO.', 5, ['cash', 'debt']],
            ['WT', 'Efisiensi energi & SDM multitasking', 'Konversi LPG→CNG, LED, rasio karyawan 0,44 dijaga dengan pelatihan silang.', 3, ['energy', 'hr']],
            ['WT', 'Pemulihan reputasi digital', 'Bersihkan akun palsu, respons semua ulasan < 24 jam, perbaiki keluhan berulang (air mineral, Wi-Fi).', 4, ['reputation']],
            ['WO', 'VHP sebagai alat operasional & Arah GPCH untuk siklus KPI', 'Semua HOD mengakses VHP; realisasi KPI tiap tanggal 5; persetujuan tanggal 8.', 4, ['reporting', 'leadership']],
        ] as [$type, $title, $desc, $prio, $iss]) {
            $t = TowsStrategy::create(['type' => $type, 'title' => $title, 'description' => $desc, 'priority' => $prio, 'status' => 'dipilih']);
            $t->issues()->sync(collect($iss)->map(fn ($k) => $issues[$k]->id));
        }
    }
}
