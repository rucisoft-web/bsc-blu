# Panduan Instalasi Arah GPCH di Laragon

Lokasi program: **`C:\laragon\www\arahgpch`** · Alamat: **http://arahgpch.test/admin**

## 1. Prasyarat

| Komponen | Ketentuan | Cara di Laragon |
|---|---|---|
| PHP | **8.3 atau lebih baru** (64-bit, NTS) | Menu Laragon › PHP › Version. Bila belum ada 8.3, unduh *PHP 8.3 VS16 x64 Non Thread Safe* (zip) dari windows.php.net, ekstrak ke `C:\laragon\bin\php\php-8.3.x`, lalu pilih versinya. |
| Ekstensi PHP | `intl`, `pdo_mysql`, `mbstring`, `zip`, `gd`, `fileinfo`, `openssl`, `bcmath` | Menu › PHP › Extensions — centang yang belum aktif (terutama **intl** dan **zip**). |
| MySQL / MariaDB | MySQL 8 atau MariaDB 10.6+ | Bawaan Laragon. Klik **Start All**. User `root` tanpa kata sandi. |
| Composer | Tidak wajib | Folder `vendor` sudah disertakan. Composer hanya dibutuhkan untuk pembaruan. |
| Node.js | Tidak dibutuhkan | Tampilan memakai stylesheet statis (`public/css/arah.css`). |

## 2. Salin program

1. Ekstrak `arahgpch.zip` sehingga ada `C:\laragon\www\arahgpch\artisan`.
2. Klik **Reload** pada Laragon (atau Stop › Start). Laragon otomatis membuat virtual host `arahgpch.test` yang mengarah ke folder `public`.

## 3. Buat database & data awal — pilih salah satu

### Cara A (disarankan): otomatis dengan skrip

Buka **Terminal** Laragon (tombol Terminal), lalu:

```bat
cd C:\laragon\www\arahgpch
setup-laragon.bat
```

Skrip melakukan: cek PHP & ekstensi → salin `.env.example` ke `.env` → `key:generate` → membuat database `arahgpch` (utf8mb4) → `migrate:fresh --seed` (51 migrasi + data awal GPCH) → `filament:assets` → `optimize:clear` → `dhastram:doctor`.

### Cara B: manual langkah demi langkah

```bat
cd C:\laragon\www\arahgpch
copy .env.example .env
php artisan key:generate
mysql -u root -e "CREATE DATABASE arahgpch CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
php artisan migrate --seed
php artisan filament:assets
php artisan optimize:clear
php artisan dhastram:doctor
```

Database juga bisa dibuat lewat tombol **Database** Laragon (HeidiSQL): klik kanan koneksi › *Create new* › *Database* › nama `arahgpch`, collation `utf8mb4_unicode_ci`.

### Cara C: impor file SQL siap pakai

File **`database/sql/arahgpch.sql`** berisi struktur 51 tabel + seluruh data awal (MySQL 8 / MariaDB).

- **Skrip:** `impor-sql.bat` (menghapus & membuat ulang database `arahgpch`, lalu mengimpor).
- **HeidiSQL:** buat database `arahgpch` › pilih database › *File* › *Load SQL file…* › `database\sql\arahgpch.sql` › Execute (F9).
- **phpMyAdmin:** pilih database `arahgpch` › tab *Import* › pilih file › Go.

Setelah impor tetap jalankan `copy .env.example .env` dan `php artisan key:generate`.

> Cara A/B dan C menghasilkan data yang sama. Ulangi Cara A kapan saja untuk kembali ke data awal (**semua perubahan akan hilang**).

## 4. Masuk ke aplikasi

Buka **http://arahgpch.test/admin**

| Akun | Email | Kata sandi |
|---|---|---|
| Super Admin (konsultan) | `admin@arahgpch.local` | `Arah@GPCH2026` |
| Semua akun jabatan (GM, CA, HOD, Timwas, dll.) | lihat README.md | `GPCH-2026!ganti` → **wajib diganti saat login pertama** |

Kata sandi baru minimal 10 karakter, mengandung huruf dan angka. Login dibatasi 5 percobaan per menit.

## 5. Pengingat otomatis (opsional di komputer lokal)

Notifikasi (pengingat input tanggal 3, verifikasi tanggal 6, persetujuan tanggal 8, milestone H-7, tindakan korektif lewat tenggat) dijalankan oleh scheduler Laravel:

- Saat uji coba: buka Terminal Laragon dan jalankan `php artisan schedule:work` (biarkan jendela terbuka).
- Permanen di Windows: Task Scheduler › Create Task › Trigger tiap 1 menit › Action: `C:\laragon\bin\php\php-8.3.x\php.exe` dengan argumen `C:\laragon\www\arahgpch\artisan schedule:run`.
- Uji manual: `php artisan arahgpch:reminders --date=2026-11-03`.

## 6. Perintah penting

| Perintah | Fungsi |
|---|---|
| `php artisan dhastram:doctor` | Pemeriksaan PHP, ekstensi, database, izin & peran |
| `php artisan dhastram:create-admin` | Membuat Super Admin baru |
| `php artisan db:seed --class=DhastramRolePermissionSeeder` | Memperbarui izin & peran (aman diulang) |
| `php artisan dhastram:gpch-cutover` | Cutover go-live: hapus data/akun demo, kosongkan log audit (dengan cadangan JSON) |
| `php artisan arahgpch:reminders` | Kirim pengingat siklus hari ini |
| `php database/tools/export-mysql.php` | Membuat ulang `database/sql/arahgpch.sql` dari database aktif |

## 7. Masalah umum

| Gejala | Solusi |
|---|---|
| `Your PHP version (8.1…) does not satisfy…` / halaman putih | Ganti PHP ke 8.3+ (lihat Prasyarat). |
| `Class "Collator" not found` / error `intl` | Aktifkan ekstensi **intl** (Menu › PHP › Extensions), restart Laragon. |
| `SQLSTATE[HY000] [1049] Unknown database 'arahgpch'` | Buat database dulu (langkah 3). |
| `SQLSTATE[HY000] [2002]` | MySQL belum jalan — klik **Start All**. |
| `arahgpch.test` tidak terbuka | Klik **Reload** di Laragon; pastikan *Menu › Preferences › Auto virtual hosts* aktif. Alternatif: `php artisan serve` lalu buka http://127.0.0.1:8000/admin. |
| Tampilan tanpa gaya | Jalankan `php artisan filament:assets` dan pastikan `public/css/arah.css` ada. |
| `419 Page Expired` | Hapus cookie situs / `php artisan optimize:clear`. |
| Huruf terlihat berbeda saat offline | Font Inter dimuat dari internet; tanpa internet memakai font sistem (tidak memengaruhi fungsi). |
