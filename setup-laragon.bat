@echo off
REM ============================================================
REM  Arah GPCH - instalasi otomatis di Laragon (Windows)
REM  Jalankan dari Terminal Laragon:  cd C:\laragon\www\arahgpch  lalu  setup-laragon.bat
REM ============================================================
setlocal
cd /d "%~dp0"
echo.
echo [1/7] Memeriksa PHP...
php -r "exit(version_compare(PHP_VERSION,'8.3.0','>=')?0:1);"
if errorlevel 1 (
  echo   PHP harus versi 8.3 atau lebih baru. Laragon: Menu ^> PHP ^> Version.
  php -v
  goto :fail
)
php -r "foreach(['intl','pdo_mysql','mbstring','zip','gd','fileinfo','openssl'] as $e) if(!extension_loaded($e)) {echo '  Ekstensi belum aktif: '.$e.PHP_EOL; $x=1;} exit($x??0);"
if errorlevel 1 (
  echo   Aktifkan ekstensi di Laragon: Menu ^> PHP ^> Extensions, lalu jalankan ulang.
  goto :fail
)

echo [2/7] Menyiapkan file .env...
if not exist .env copy .env.example .env >nul
php artisan key:generate --force

echo [3/7] Membuat database arahgpch (MySQL root tanpa sandi)...
mysql -u root -e "CREATE DATABASE IF NOT EXISTS arahgpch CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
if errorlevel 1 (
  echo   Gagal membuat database. Pastikan MySQL Laragon sudah Start, atau buat manual lewat HeidiSQL.
  goto :fail
)

if not exist vendor\autoload.php (
  echo [3b] Folder vendor tidak ada - menjalankan composer install...
  call composer install --no-interaction
)

echo [4/7] Membuat tabel dan memuat data awal Grand Pasundan...
php artisan migrate:fresh --seed --force
if errorlevel 1 goto :fail

echo [5/7] Menyalin aset Filament...
php artisan filament:assets

echo [6/7] Membersihkan cache...
php artisan optimize:clear

echo [7/7] Pemeriksaan konfigurasi...
php artisan dhastram:doctor

echo.
echo ============================================================
echo  SELESAI. Buka  http://arahgpch.test/admin
echo  (klik Reload di Laragon bila virtual host belum aktif)
echo  Login super admin : admin@arahgpch.local / Arah@GPCH2026
echo  Akun jabatan      : lihat README.md (sandi awal GPCH-2026!ganti)
echo ============================================================
goto :eof

:fail
echo.
echo Instalasi berhenti. Lihat PANDUAN-LARAGON.md bagian "Masalah umum".
exit /b 1
