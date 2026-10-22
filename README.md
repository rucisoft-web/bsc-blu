# Arah GPCH — Manajemen Strategi Grand Pasundan

Edisi **DHASTRAM** untuk **Grand Pasundan Convention Hotel** (Jl. Peta No. 147–149, Bandung · 164 kamar · Malibu Dome 1.200 pax).
Instalasi tunggal, satu perusahaan (kode `GPCH`), tanpa mode demo/tamu, dengan istilah umum bahasa Indonesia.

**Instalasi di Laragon → [PANDUAN-LARAGON.md](PANDUAN-LARAGON.md)** · Sumber & validasi data awal → [docs/DATA-AWAL.md](docs/DATA-AWAL.md)

## Teknologi

| Lapisan | Komponen |
|---|---|
| Runtime | PHP 8.3+, **Laravel 13**, Livewire 4 |
| Antarmuka | **Filament v5** (panel `/admin`), tema Kamasan: kertas `#F6EFDF`, tinta `#2B2118`, taum `#34506E`, kencu `#A8432A` |
| Basis data | **MySQL 8 / MariaDB 10.6+** — 51 migrasi (48 aplikasi + 3 bawaan Laravel) |
| Konteks | `DhastramContext` (sesi + tabel `user_contexts`) & global scope `BelongsToDhastramContext` menyaring setiap query per perusahaan/perioda |
| Penomoran | `DhastramSequence` → `OBJ/GPCH/2026/001`, `KPI/…`, `INI/…`, `TMN/…`, `REV/…` |
| Audit | `audit_logs` mencatat buat/ubah/hapus oleh pengguna (`DHASTRAM_AUDIT_ENABLED`) |
| Antrian & jadwal | driver database; `arahgpch:reminders` harian 07.30 WIB |

Istilah diatur `DHASTRAM_TERMS=umum` (Ekosistem, Jati Diri, Kinerja, Perbaikan, Kesinambungan; Keuangan, Kepuasan Pelanggan, Proses Internal, SDM & Pembelajaran) atau `dharma` (Brahman, Atman, Karma Phala, Punarbhawa, Moksa; Artha, Kama, Dharma, Swadharma).

## Modul

- **Umum:** Beranda (tugas saya), Pusat Kendali Eksekutif, Alur Kerja Arah GPCH, Peta Strategi, Laporan (+ unduh Excel), Pilih Perioda.
- **Ekosistem:** Pemindaian Lingkungan, PESTEL, Analisis Industri, Pasar & Pelanggan, Analisis Pesaing, Analisis Regulasi, Pemangku Kepentingan, Isu Strategis, SWOT, TOWS.
- **Jati Diri:** Jati Diri Organisasi (visi, misi, nilai inti, budaya), Kapabilitas Organisasi.
- **Kinerja:** Tema Strategis, Pilihan Strategis, Sasaran Strategis, Relasi Sasaran, KPI, Target KPI, Realisasi KPI (alur draf → terverifikasi → disetujui/terkunci, kembalikan), Tinjauan Kinerja (+ catatan pengawasan Timwas).
- **Perbaikan:** Portofolio Inisiatif (matriks Nilai × Upaya), Inisiatif Strategis, Aktivitas, Milestone, Anggaran, Temuan (tutup hanya bila semua tindakan selesai), Tindakan Korektif.
- **Kesinambungan:** Kematangan Manajemen Strategi, Ketergantungan Strategis, Institusionalisasi.
- **Administrasi:** Perusahaan (hanya Super Admin), Pengguna, Peran, Penugasan Peran, Log Audit.

34 resource + 7 halaman khusus. Layanan inti di `app/Services`: `KpiScoringService`, `StrategicScoreService`, `InitiativeProgressService`, `InitiativePortfolioService`, `MaturityScoringService`, `KpiApprovalService`, `ExecutiveDashboardService`, `HomeDashboardService`, `StrategyMapService`, `OperationalWorkflowService`, `DhastramReportService`.

## Hak akses

32 izin (25 izin DHASTRAM + `kpi.verify_finance`, `initiative.budget`, `review.note`, `finding.create`, `data.manage_all`). Peran diberikan **per perusahaan** (`role_user.company_id = GPCH`); satu orang boleh punya beberapa peran.

Pembatasan "miliknya": pemilik KPI hanya mengisi realisasi KPI miliknya; PIC hanya memperbarui aktivitas/milestone inisiatif miliknya; pemilik tindakan korektif hanya mengubah miliknya. GM, Koordinator Manajemen Strategi (`data.manage_all`) dan Super Admin bebas. Realisasi yang disetujui terkunci; koreksi hanya oleh GM dan tercatat di log audit.

Keamanan login: kata sandi minimal 10 karakter (huruf & angka), batas 5 percobaan/menit, wajib ganti sandi saat login pertama, opsi 2FA aplikasi autentikator di halaman profil (`ARAH_MFA_REQUIRED=true` mewajibkan untuk GM, Timwas & admin).

## Akun awal

Super Admin: `admin@arahgpch.local` / `Arah@GPCH2026`. Akun lain: kata sandi awal **`GPCH-2026!ganti`** (wajib diganti). Email masih usulan — konfirmasi dengan HR.

| Nama | Jabatan | Email | Peran |
|---|---|---|---|
| Konsultan DHASTRAM | Konsultan / vendor DHASTRAM | `admin@arahgpch.local` | super-admin |
| Admin EDP GPCH (isi nama) | EDP / IT Manager | `edp@grandpasundanhotel.com` | gpch-admin-sistem |
| Bapak Wilfred | Ketua Tim Pengawas | `wilfred@grandpasundanhotel.com` | gpch-pengawas |
| Ibu Vivera | General Manager | `gm@grandpasundanhotel.com` | gpch-gm |
| Koordinator Manajemen Strategi (isi nama) | Koordinator Manajemen Strategi (staf GM) | `strategi@grandpasundanhotel.com` | strategy-office |
| Bapak Indra | Chief Accountant | `ca@grandpasundanhotel.com` | gpch-keuangan |
| Ibu Irina | Sales & Marketing Manager | `sales@grandpasundanhotel.com` | gpch-kepala-dept, gpch-editor-ekosistem |
| Bapak Rizki | Front Office Manager | `fom@grandpasundanhotel.com` | gpch-kepala-dept |
| Bapak Asep Agus Damil Arifin | F&B Manager / Executive Chef | `fbm@grandpasundanhotel.com` | gpch-kepala-dept |
| Bapak Wahyudin | Chief Engineer (Plt.) | `engineering@grandpasundanhotel.com` | gpch-kepala-dept |
| Ibu Wina | Executive Housekeeper (Plt.) | `hk@grandpasundanhotel.com` | gpch-kepala-dept |
| Bapak Anto | HR Manager | `hrd@grandpasundanhotel.com` | gpch-kepala-dept, gpch-editor-jatidiri |
| Bapak Daniel | Purchasing | `purchasing@grandpasundanhotel.com` | gpch-kepala-dept |
| Ibu Rika | Sales Executive | `rika.sales@grandpasundanhotel.com` | gpch-pelaksana |
| Arsy | Sales Executive | `arsy.sales@grandpasundanhotel.com` | gpch-pelaksana |
| Muhamad Ihsan | Front Office Supervisor | `fo.supervisor@grandpasundanhotel.com` | gpch-pelaksana |
| Ujang Nur M | Housekeeping Supervisor | `hk.supervisor@grandpasundanhotel.com` | gpch-pelaksana |
| Rara | Engineering Admin | `eng.admin@grandpasundanhotel.com` | gpch-pelaksana |
| Bapak Wimpy | Pemilik | `owner@grandpasundanhotel.com` | viewer |
| Bapak Yodi S. Ibrahim | Direksi | `yodi@grandpasundanhotel.com` | management |
| Bapak Miko | Anggota Tim Pengawas | `miko@grandpasundanhotel.com` | viewer |
| Bapak Joice | Anggota Tim Pengawas | `joice@grandpasundanhotel.com` | viewer |
| Ibu Yuli | Anggota Tim Pengawas | `yuli@grandpasundanhotel.com` | viewer |
| Bapak I.G. Wiwin Suyasa | Auditor Operasional (Visi Perencana Indonesia) | `wiwin@visiperencana.id` | viewer |

## Siklus kerja

Input realisasi tgl 5 → verifikasi Chief Accountant tgl 7 → persetujuan GM tgl 8 → rapat manajemen tgl 10. GM Weekly Report setiap Senin dicatat sebagai Tinjauan Kinerja.

## Produksi (cPanel)

`APP_ENV=production`, `APP_DEBUG=false`, `SESSION_SECURE_COOKIE=true`; kode di luar `public_html`, document root ke `public/`; cron `* * * * * php ~/arahgpch/artisan schedule:run`.
Pada produksi `DatabaseSeeder` hanya membuat izin/peran & pertanyaan kematangan; data GPCH dipindahkan sekali (impor SQL atau `ARAH_SEED_GPCH=true`) lalu `php artisan dhastram:gpch-cutover`.
Rilis: unggah kode → `composer install --no-dev --optimize-autoloader` → `php artisan migrate --force` → `php artisan optimize` → `php artisan dhastram:doctor`.
