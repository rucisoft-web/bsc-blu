<?php

namespace Database\Seeders\Gpch;

use App\Models\AtmanProfile;
use App\Models\Capability;
use App\Models\CoreValue;

class IdentitySeeder
{
    public function seed(array $u): void
    {
        AtmanProfile::create([
            'vision' => 'Menjadi hotel dan pusat konvensi serbaguna berbasis pengalaman Pasundan yang menjadi kebanggaan Bandung dan pilihan utama korporasi, instansi, komunitas, dan keluarga.',
            'mission' => "1. Menghadirkan pengalaman menginap dan berkegiatan yang autentik bernuansa Sunda melalui pelayanan someah, kuliner, dan cerita.\n2. Menyediakan venue MICE, wedding, dan acara sosial yang layak, fleksibel, dan bernilai bagi pelanggan.\n3. Mengelola keuangan secara disiplin dan transparan dengan laporan bulanan yang lengkap (laba rugi, arus kas, neraca).\n4. Merawat aset dan fasilitas secara terencana agar nilai properti terus meningkat.\n5. Membangun SDM multitasking yang kompeten, sejahtera, dan bangga bekerja di Grand Pasundan.",
            'purpose' => 'Mengembalikan kejayaan Grand Pasundan sebagai landmark hotel & convention Bandung yang melestarikan tradisi Pasundan.',
            'tagline' => 'Preserve Pasundan Tradition',
            'brand_promise' => 'Kamar luas, venue besar, dan keramahan Sunda — setiap kunjungan meninggalkan cerita.',
            'value_proposition' => 'Satu-satunya hotel bintang 4 di koridor Pasir Koja dengan convention hall 1.200 pax, 13 ruang rapat, kamar berukuran luas, kolam renang besar, dan pengalaman kuliner & budaya Sunda dengan harga terjangkau.',
            'culture_statement' => 'Kita bekerja sebagai satu tim: bersepakat dalam rapat berarti bersepakat dalam tindakan. Ketegasan pimpinan adalah bentuk menegakkan aturan, bukan tekanan. Sistem adalah alat operasional, bukan sekadar laporan.',
            'history' => 'Didirikan sebagai landmark hotel & convention utama Bandung dengan lahan luas dan bangunan kokoh. Assessment Des 2024 mencatat aura kejayaan mulai pudar; Konsep Kerja Maret 2025 menetapkan arah hotel serbaguna berbasis pengalaman; VHP Cloud live April 2025; Tim Pengawas aktif mengawasi sejak 2026; GM baru bergabung 1 Oktober 2026.',
            'approved_by' => $u['gm']->id,
            'approved_at' => '2026-10-12 10:00:00',
        ]);

        foreach ([
            ['Someah', 'Someah hade ka semah', 'Ramah, hangat, dan melayani sepenuh hati seperti menyambut tamu di rumah sendiri.', "Menyapa tamu dengan senyum dan salam\nMenyampaikan cerita singkat tentang Pasundan kepada tamu\nMembalas setiap ulasan tamu dalam 24 jam"],
            ['Sabilulungan', 'Gotong royong', 'Bekerja sama lintas departemen; tim yang kuat lebih penting dari bintang perorangan.', "Membantu departemen lain saat peak (multitasking)\nMelaporkan kerusakan yang ditemukan meski bukan tugasnya\nTidak saling menyalahkan dalam rapat"],
            ['Jujur & Amanah', 'Jujur', 'Mencatat dan melaporkan apa adanya, termasuk biaya dan persediaan.', "Tidak menangguhkan beban di data persediaan\nBukti pendukung untuk setiap realisasi KPI\nMenjaga dana deposit tamu sesuai peruntukannya"],
            ['Disiplin', 'Taat kana aturan', 'Taat pada SOP, jadwal, dan keputusan rapat.', "Input realisasi KPI paling lambat tanggal 5\nTindak lanjut MoM sesuai timeline & PIC\nMenegur sesuai peraturan, bukan menekan"],
            ['Berorientasi Hasil', 'Hasil', 'Tujuan pemilik hanya satu: hasil. Setiap kegiatan harus berdampak pada pendapatan, biaya, atau kepuasan tamu.', "Mengukur dampak setiap promo\nMencari peluang event yang sedang tren\nMengurangi pemborosan"],
            ['Silih Asah', 'Silih asah, silih asih, silih asuh', 'Terus belajar dan saling mengajari agar kompeten dan berkembang.', "Mengikuti refresh training departemen\nMembimbing siswa PKL & trainee\nBerbagi praktik baik dalam briefing"],
        ] as $i => [$name, $local, $desc, $beh]) {
            CoreValue::create(['name' => $name, 'local_name' => $local, 'description' => $desc, 'behaviors' => $beh, 'sort' => $i + 1]);
        }

        foreach ([
            ['Malibu Dome & 13 ruang rapat', 'Sumber daya fisik', 'Convention hall 48×24 m (1.152 m²) untuk 1.200 pax theater; Half Malibu 500 pax; Jayagiri 272 m²; Wastukantjana, Niskala, Citraganda, Sri Baduga, Sangkuriang, Arimbi, Linggabumi, Linggawarman, Dayang Sumbi, Raga Suci, Layungwangi.', 4, 5, true, 'Perbaiki plafon Jayagiri, karpet, screen & AV (smartboard).'],
            ['Kamar luas & variasi suite', 'Sumber daya fisik', '155 kamar + 7 suite + 3-Bedroom Pasundan Suite; Standard 3×5 m, Deluxe/Executive 4×8 m, Grand Family Suite, President Suite (lt. 11).', 4, 4, true, 'Refresh kamar bertahap (20 kamar/periode), pencahayaan kerja & amenities.'],
            ['Lahan, parkir & kolam renang', 'Sumber daya fisik', 'Parkir ±200 kendaraan, kolam renang besar, kids corner, D\'Linda Poolside Cafetaria.', 4, 4, true, 'Redesign area kolam agar lebih berkelas; perbaiki sand filter.'],
            ['Kuliner Sunda & breakfast', 'Kompetensi', 'Nasi Timbel Empal, nampan nasi liwet & tutug oncom, peyeum goreng; breakfast melampaui budget.', 3, 4, true, 'Standard recipe di VHP, menu bercerita, kelas memasak Sunda.'],
            ['Penjualan MICE & pemerintahan', 'Kompetensi', 'Relasi dengan instansi Kota/Kab. Bandung & Jabar; tim sales (Irina, Rika, Arsy, Lisma).', 3, 4, false, 'Daily pipeline report, pitching korporasi & EO.'],
            ['Pemasaran digital & e-commerce', 'Kompetensi', 'WA blast, OTA campaign, booking engine, metasearch Google (Alaric).', 2, 4, false, 'Konten storytelling, influencer, promo code website.'],
            ['Manajemen keuangan & pelaporan', 'Sistem', 'Laporan keuangan bulanan belum lengkap; neraca baru disusun; disiplin persediaan.', 2, 4, false, 'Tiga laporan wajib tiap bulan; proyeksi kas mingguan.'],
            ['Sistem informasi (VHP Cloud & Arah GPCH)', 'Sistem', 'VHP live Apr 2025 (FO, POS, NA, IA, AR, Banquet); back office menunggu data master.', 2, 4, false, 'Lengkapi saldo awal, artikel, supplier; dashboard VHP; Arah GPCH untuk KPI.'],
            ['Pemeliharaan preventif', 'Kompetensi', 'Tim engineering terbatas (4 teknisi pada 2024); CE masih Plt.', 2, 4, false, 'Rekrut CE, jadwal preventif, dokumentasi & pelaporan maintenance.'],
            ['SDM pelayanan multitasking', 'Kompetensi', '72 karyawan (PKWT 34, daily worker 38) + 17 trainee; rasio 0,44/kamar.', 3, 4, false, 'Pelatihan silang, evaluasi kinerja bulanan, program PKL.'],
        ] as [$name, $cat, $desc, $cur, $tgt, $core, $gap]) {
            Capability::create(['name' => $name, 'category' => $cat, 'description' => $desc, 'current_level' => $cur, 'target_level' => $tgt, 'is_core' => $core, 'gap_action' => $gap]);
        }
    }
}
