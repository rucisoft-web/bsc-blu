# Ruci BSC Professional

Aplikasi **Balanced Scorecard multi-perusahaan** berbasis Laravel + MySQL, dikembangkan dari edisi DHASTRAM (ARAH GPCH).
Satu instalasi melayani banyak perusahaan; setiap perusahaan punya data, perioda, admin dan pengguna sendiri, dan datanya bisa diupload satu per satu lewat file Excel.

**Instalasi di Laragon → [PANDUAN-LARAGON.md](PANDUAN-LARAGON.md)**

## Teknologi

| Lapisan | Komponen |
|---|---|
| Runtime | PHP 8.3+, **Laravel 13**, Livewire 4 |
| Antarmuka | **Filament v5** (panel `/admin`), stylesheet statis `public/css/arah.css` (tanpa Node.js) |
| Basis data | **MySQL 8 / MariaDB 10.6+** (SQLite untuk test) |
| Konteks | `DhastramContext` (sesi + tabel `user_contexts`) & global scope `BelongsToDhastramContext` menyaring setiap query per perusahaan/perioda |
| Excel | OpenSpout: import, template kosong, dan ekspor data perioda |
| Audit | `audit_logs` mencatat buat/ubah/hapus (`DHASTRAM_AUDIT_ENABLED`) |
| Jadwal | `rucibsc:reminders` harian (pengingat siklus input → verifikasi → persetujuan) |

## Multi-perusahaan

- **Super Admin** mengelola semua perusahaan, peran, dan semua akun.
- **Company Admin** mengelola pengguna dan penugasan peran **hanya di perusahaan yang sedang aktif**. Akun yang juga terdaftar di perusahaan lain hanya bisa diubah Super Admin (mencegah reset sandi lintas perusahaan).
- Peran diberikan per perusahaan (`role_user.company_id`); satu orang boleh punya peran di beberapa perusahaan dan berpindah lewat **Pilih Perusahaan & Perioda**.

## Import data perusahaan (menu Administrasi › Import Data)

1. Pilih perusahaan & perioda tujuan.
2. Unduh **template kosong** atau **ekspor data perioda saat ini**.
3. Isi sheet yang diperlukan: Jati Diri, Nilai Inti, Tema, Sasaran, Relasi Sasaran, KPI, Target, Realisasi, Inisiatif. Sheet yang tidak ada di file tidak diubah.
4. **Pratinjau** dulu (tidak menyimpan apa pun), lalu **Proses Import**.

Kode (sasaran, KPI, tema, inisiatif) menjadi kunci, jadi upload ulang memperbarui data, bukan menduplikasi. Baris yang salah dilewati dan dilaporkan dengan nomor barisnya. Angka boleh format Indonesia (`11.098.665`, `6,62`). Realisasi masuk sebagai **draf**, kecuali pengguna punya izin persetujuan dan mencentang "langsung setujui". Import terakhir sebuah perioda bisa **dibatalkan** (nilai sebelumnya dipulihkan). Izin: `import.manage`.

## Modul

- **Umum:** Beranda, Pusat Kendali Eksekutif, Alur Kerja, Peta Strategi, Laporan (+ Excel), Pilih Perusahaan & Perioda.
- **Ekosistem:** Pemindaian Lingkungan, PESTEL, Analisis Industri, Pasar & Pelanggan, Pesaing, Regulasi, Pemangku Kepentingan, Isu Strategis, SWOT, TOWS.
- **Jati Diri:** visi, misi, nilai inti, budaya, kapabilitas.
- **Kinerja:** Tema, Pilihan Strategis, Sasaran, Relasi Sasaran, KPI, Target, Realisasi (draf → terverifikasi → disetujui/terkunci, atau dikembalikan), Tinjauan Kinerja.
- **Perbaikan:** Portofolio & Inisiatif Strategis, Aktivitas, Milestone, Anggaran, Temuan, Tindakan Korektif.
- **Kesinambungan:** Kematangan Manajemen Strategi, Ketergantungan, Institusionalisasi.
- **Administrasi:** Perusahaan, Pengguna, Peran, Penugasan Peran, Import Data, Log Audit.

Skor KPI: polaritas naik = realisasi ÷ target × 100, turun = target ÷ realisasi × 100, maksimal 120; hijau ≥ 100, kuning ≥ 80. Agregasi jumlah, rata-rata, atau terakhir.

## Peran bawaan

`super-admin`, `company-admin`, `strategy-office`, `management`, `pimpinan`, `keuangan`, `kepala-unit`, `kpi-owner`, `initiative-pic`, `reviewer`, `pengawas`, `admin-sistem`, `editor-ekosistem`, `editor-jatidiri`, `pelaksana`, `viewer`. Isi izin peran berlaku global dan hanya diubah Super Admin.

## Data contoh

Di luar produksi (atau bila `RUCI_SEED_DEMO=true`) seeder memuat tiga perusahaan contoh lewat jalur import yang sama:

| Kode | Perusahaan | Isi |
|---|---|---|
| DFI | PT Diamond Food Indonesia Tbk | Perioda 2025, KPI dari laporan tahunan 2025 |
| NLP | PT Nusantara Logistik Prima (fiktif) | Perioda 2026 (Jan–Agu disetujui, Sep draf) + 2027 perencanaan |
| KSB | Klinik Sehat Bersama (fiktif) | Perioda 2026 |

Akun: Super Admin `admin@rucibsc.local` / `Ruci@BSC2026` (ubah lewat `RUCI_ADMIN_PASSWORD`). Akun contoh per perusahaan, kata sandi `Contoh-2026!`:
`dfi.admin@contoh.local`, `dfi.direktur@…`, `dfi.keuangan@…`, `dfi.komersial@…`, `dfi.sdm@…`, dan pola yang sama untuk `nlp.*` dan `ksb.*`.

Sebelum dipakai sungguhan: `php artisan rucibsc:hapus-contoh` menghapus semua perusahaan dan akun contoh, lalu ganti sandi Super Admin.

## Perintah penting

| Perintah | Fungsi |
|---|---|
| `php artisan dhastram:doctor` | Cek PHP, ekstensi, database, izin, peran, data contoh |
| `php artisan dhastram:create-admin` | Membuat Super Admin baru |
| `php artisan db:seed --class=DhastramRolePermissionSeeder` | Memperbarui izin & peran (aman diulang) |
| `php artisan rucibsc:hapus-contoh` | Menghapus perusahaan & akun contoh |
| `php artisan rucibsc:reminders --date=2026-11-03` | Uji pengingat |
| `php vendor/bin/phpunit` | Menjalankan test otomatis |

## Produksi (cPanel / VPS)

`APP_ENV=production`, `APP_DEBUG=false`, `SESSION_SECURE_COOKIE=true`; document root ke `public/`; cron `* * * * * php /path/ruci-bsc/artisan schedule:run`.
Di produksi `DatabaseSeeder` hanya membuat izin, peran, dan pertanyaan kematangan. Buat Super Admin dengan `dhastram:create-admin`, tambahkan perusahaan, lalu upload datanya lewat Import Data.
Rilis: `composer install --no-dev --optimize-autoloader` → `php artisan migrate --force` → `php artisan optimize` → `php artisan dhastram:doctor`.
