<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Produksi (APP_ENV=production): hanya peran/izin & pertanyaan kematangan.
     * Lokal/staging: ditambah data awal Grand Pasundan (GpchSeeder).
     */
    public function run(): void
    {
        $this->call([
            DhastramRolePermissionSeeder::class,
            MaturityQuestionSeeder::class,
        ]);

        if (! app()->isProduction() || env('ARAH_SEED_GPCH', false)) {
            $this->call(GpchSeeder::class);
        }
    }
}
