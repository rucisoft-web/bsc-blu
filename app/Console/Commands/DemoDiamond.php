<?php

namespace App\Console\Commands;

use App\Models\AnalysisPeriod;
use App\Models\Company;
use App\Models\MaturityQuestion;
use App\Models\Role;
use App\Support\DhastramContext;
use Database\Seeders\DhastramRolePermissionSeeder;
use Database\Seeders\DiamondFoodSeeder;
use Database\Seeders\MaturityQuestionSeeder;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

/** Memuat demo lengkap PT Diamond Food Indonesia Tbk (perioda 2025 + 2026) ke server yang sudah berjalan. */
class DemoDiamond extends Command
{
    protected $signature = 'rucibsc:demo-diamond
        {--password= : Kata sandi akun dfi.*@contoh.local (bila kosong dibuat acak dan ditampilkan)}
        {--reset : Hapus dulu data DFI perioda 2025 & 2026 yang sudah ada}
        {--force : Lewati konfirmasi}';

    protected $description = 'Muat demo lengkap Diamond Food (Strategy Map, KPI, inisiatif, ekosistem, tinjauan) untuk perioda 2025 & 2026';

    public function handle(): int
    {
        if (! Role::exists()) {
            $this->call('db:seed', ['--class' => DhastramRolePermissionSeeder::class, '--force' => true]);
        }
        if (! MaturityQuestion::exists()) {
            $this->call('db:seed', ['--class' => MaturityQuestionSeeder::class, '--force' => true]);
        }

        $company = Company::where('code', DiamondFoodSeeder::CODE)->first();
        $periods = $company ? AnalysisPeriod::where('company_id', $company->id)->whereIn('code', ['2025', '2026'])->get() : collect();
        if ($periods->isNotEmpty()) {
            if (! $this->option('reset')) {
                $this->error('Perusahaan DFI sudah punya perioda '.$periods->pluck('code')->join(' & ').'. Jalankan ulang dengan --reset untuk menggantinya dengan data demo.');

                return self::FAILURE;
            }
            if (! $this->option('force') && ! $this->confirm('Semua data DFI perioda '.$periods->pluck('code')->join(' & ').' akan dihapus dan diganti data demo. Lanjutkan?')) {
                return self::FAILURE;
            }
        }

        $password = $this->option('password') ?: Str::password(14, symbols: false);
        DB::transaction(function () use ($periods, $password) {
            $periods->each->delete(); // seluruh tabel data perioda memakai cascadeOnDelete
            (new DiamondFoodSeeder($password))->run();
        });
        app(DhastramContext::class)->clear();

        $this->info('Demo Diamond Food siap: perioda 2025 (ditutup) & 2026 (berjalan, bawaan).');
        $this->line('Akun contoh: dfi.admin, dfi.direktur, dfi.keuangan, dfi.komersial, dfi.rantaipasok, dfi.produksi, dfi.sdm, dfi.ti, dfi.strategi, dfi.komisaris, dfi.analis (@contoh.local)');
        if (! $this->option('password')) {
            $this->warn('Kata sandi akun contoh: '.$password);
        }
        $this->line('Hapus semua data contoh sebelum go-live dengan: php artisan rucibsc:hapus-contoh');

        return self::SUCCESS;
    }
}
