# Data Awal Arah GPCH — sumber & status validasi

Seluruh data awal dibuat oleh `database/seeders/GpchSeeder.php` (dan dibekukan ke `database/sql/arahgpch.sql`).
Sesuai spesifikasi, **angka yang tidak berasal dari dokumen diberi tanda PROYEKSI** dan wajib dikonfirmasi pemiliknya
(Chief Accountant mencocokkan dengan laporan VHP pada minggu validasi) atau dihapus sebelum dikunci.

## Dokumen sumber

| Dokumen | Dipakai untuk |
|---|---|
| GM Weekly Report 21–27 Sep 2026 | Revenue MTD vs budget, okupansi, ADR, RevPAR, outlet F&B, banquet, kompetitor (RGI/MPI/ARI & rating), lost business Rp192,5 jt, promo, energi, rasio karyawan, guest comments, rencana dept. |
| MoM Rapat Manajemen 23 Sep 2026 | Tinjauan kinerja, action plan revenue recovery, arahan pemilik/direksi, permintaan VHP (Ticket #181ADD). |
| Notulen Rapat GBK–GPCH 3 Jun 2026 | Tinjauan Timwas: penangguhan beban Rp667,5 jt, rekening BJB/BRI, penugasan purchasing. |
| Analisis Singkat Keuangan Juni 2026 | Likuiditas: penerimaan/pengeluaran, aset lancar, kewajiban, deposit OTA, PBB, utang CEO. |
| Konsep Kerja GPCH 2025 | Konsep hotel serbaguna berbasis pengalaman, segmen, kemitraan TA/EO, outsourcing. |
| The Grand Pasundan: Assessment Awal (Des 2024) | Kondisi fasilitas & SDM, pelaporan keuangan, rekomendasi PMS. |
| Spesifikasi implementasi VHP (Excel) | Status modul VHP, tim FO/F&B/HK. |
| grandpasundanhotel.com | Profil hotel, kamar & suite, 13 ruang rapat, Malibu Dome, outlet & fasilitas. |

## Isi data

| Kelompok | Jumlah | Catatan |
|---|---|---|
| Perusahaan & perioda | 1 (GPCH) · 2026 berjalan · 2027 perencanaan | 2027 berisi salinan jati diri & tema (draf) dan agenda budgeting. |
| Pengguna | 24 akun per jabatan | Nama dari MoM & tanda tangan weekly report; **email usulan** — konfirmasi HR. Dua akun bertanda "(isi nama)". |
| Ekosistem | 6 pemindaian, 14 PESTEL, 5 kekuatan industri, 9 segmen pasar, 5 pesaing, 9 regulasi, 13 pemangku kepentingan, **12 isu strategis**, 18 SWOT, 10 TOWS | Porsi segmen pasar = PROYEKSI. |
| Jati Diri | Visi, misi (5), tagline *Preserve Pasundan Tradition*, 6 nilai inti bernuansa Sunda, 10 kapabilitas | Rumusan usulan — sahkan bersama GM & pemilik. |
| Kinerja | 4 tema, 10 pilihan strategis, **13 sasaran**, 18 relasi, **28 KPI**, 330 target bulanan, **246 realisasi Jan–Sep** (231 bertanda proyeksi) | Lihat tabel di bawah. |
| Tinjauan | 6 tinjauan (Timwas 3 Jun, Q2, Jul & Agu (draf), rapat 23 Sep, weekly 21–27 Sep) + 2 catatan Timwas | Tinjauan Jul–Agu bertanda PROYEKSI, lengkapi notulen asli. |
| Perbaikan | **11 inisiatif**, 43 aktivitas, 21 milestone, 28 pos anggaran, 9 temuan, 20 tindakan korektif | Nilai anggaran = PROYEKSI. Temuan dari dokumen. |
| Kesinambungan | 25 pertanyaan kematangan, 1 penilaian baseline (skor 2,04), 7 ketergantungan, 10 mekanisme pelembagaan | Ulangi penilaian Nov–Des 2026. |

## Realisasi KPI — status awal

| Status | Arti |
|---|---|
| **Terverifikasi** (5 baris) | Angka keuangan yang langsung tercantum di dokumen (mis. surplus kas 0,91% Juni, rasio aset lancar 44,8%, piutang lama Rp143,07 jt, pembelian F&B 52%, energi 53,39%). |
| **Draf** — tidak bertanda proyeksi | Angka non-keuangan dari dokumen (okupansi & ARR Agustus, RGI 0,92, rating Google 4,4, direct booking 11%, lost business Rp192,5 jt, rasio karyawan 0,44). Perlu disetujui GM. |
| **Draf — PROYEKSI** | Diisi untuk melengkapi tren Jan–Sep; revenue September adalah ekstrapolasi MTD 1–27 Sep ke 30 hari. **Ganti dengan angka VHP** lalu ajukan ulang. |
| **Dikembalikan** (1 baris) | Food cost Maret — contoh alur pengembalian (penangguhan beban). |

Anggaran 2026 per bulan memakai budget September dari weekly report (room Rp1.031 jt, F&B Rp1.586,4 jt, banquet Rp1.308,9 jt, okupansi 52,54%, ADR Rp398.860) dan pola musiman (Ramadan Feb–Mar, libur sekolah Jun–Jul, akhir tahun) — **PROYEKSI, ganti dengan budget resmi 2026**.

## Daftar periksa sebelum kickoff

1. HR: konfirmasi nama, email & jabatan; isi dua akun "(isi nama)"; nonaktifkan yang tidak dipakai.
2. Chief Accountant: filter Realisasi KPI › *Proyeksi = ya*, cocokkan dengan VHP/keuangan, perbaiki atau hapus.
3. Kepala departemen: periksa KPI, target & aktivitas inisiatif miliknya.
4. GM: setujui realisasi Jan–Sep (aksi massal *Setujui terpilih*), sahkan Jati Diri.
5. Jalankan `php artisan dhastram:gpch-cutover` di produksi agar log audit dimulai dari go-live.
