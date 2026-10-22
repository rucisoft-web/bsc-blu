@echo off
REM Alternatif tanpa artisan migrate: impor dump MySQL siap pakai.
cd /d "%~dp0"
mysql -u root -e "DROP DATABASE IF EXISTS arahgpch; CREATE DATABASE arahgpch CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -u root arahgpch < database\sql\arahgpch.sql
if errorlevel 1 (echo Impor gagal. & exit /b 1)
if not exist .env copy .env.example .env >nul
php artisan key:generate --force
php artisan optimize:clear
echo Impor selesai. Buka http://arahgpch.test/admin
