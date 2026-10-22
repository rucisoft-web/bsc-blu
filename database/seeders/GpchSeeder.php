<?php

namespace Database\Seeders;

use App\Models\AnalysisPeriod;
use App\Models\Company;
use App\Support\DhastramContext;
use Database\Seeders\Gpch\ContinuitySeeder;
use Database\Seeders\Gpch\EcosystemSeeder;
use Database\Seeders\Gpch\IdentitySeeder;
use Database\Seeders\Gpch\ImprovementSeeder;
use Database\Seeders\Gpch\PerformanceSeeder;
use Database\Seeders\Gpch\Planning2027Seeder;
use Database\Seeders\Gpch\UserSeeder;
use Illuminate\Database\Seeder;

/**
 * Data awal Arah GPCH — Grand Pasundan Convention Hotel.
 * Sumber: GM Weekly Report 21–27 Sep 2026, MoM Rapat 23 Sep 2026, Notulen GBK-GPCH 3 Jun 2026,
 * Analisis Singkat Keuangan Juni 2026, Konsep Kerja 2025, Assessment Awal Des 2024, situs grandpasundanhotel.com.
 * Angka yang tidak ada di dokumen ditandai PROYEKSI pada kolom catatan dan wajib dikonfirmasi pemiliknya.
 */
class GpchSeeder extends Seeder
{
    public function run(): void
    {
        $company = Company::updateOrCreate(['code' => config('dhastram.company_code', 'GPCH')], [
            'name' => 'Grand Pasundan Convention Hotel',
            'legal_name' => 'Grand Pasundan Convention Hotel',
            'industry' => 'Hotel & Convention (bintang 4)',
            'address' => 'Jl. Peta No. 147–149, Suka Asih, Kec. Bojongloa Kaler',
            'city' => 'Bandung, Jawa Barat 40232',
            'phone' => '022 6043135 / WA 0811 2266 959',
            'email' => 'reservation@grandpasundanhotel.com',
            'website' => 'https://grandpasundanhotel.com',
            'room_count' => 164,
            'description' => 'Hotel bintang 4 dengan 164 kamar (155 kamar, 7 suite, 3-Bedroom Pasundan Suite), Malibu Dome Convention Hall 1.152 m² (1.200 pax theater), 13 ruang rapat, coffee shop (Cafe Delapan), D\'Linda Poolside Cafetaria, lobby lounge, kolam renang, fitness & spa, family karaoke, kids corner, Pustaka Pasundan, parkir ±200 kendaraan. Konsep: "Preserve Pasundan Tradition".',
            'is_active' => true,
        ]);
        $p2026 = AnalysisPeriod::updateOrCreate(['company_id' => $company->id, 'code' => '2026'], [
            'name' => 'Perioda 2026', 'year' => 2026, 'start_date' => '2026-01-01', 'end_date' => '2026-12-31',
            'status' => 'berjalan', 'is_active' => true, 'notes' => 'Realisasi Jan–Sep 2026 dimuat dari Review Keuangan & GM Weekly Report; wajib divalidasi Chief Accountant sebelum dikunci.',
        ]);
        $p2027 = AnalysisPeriod::updateOrCreate(['company_id' => $company->id, 'code' => '2027'], [
            'name' => 'Perioda 2027', 'year' => 2027, 'start_date' => '2027-01-01', 'end_date' => '2027-12-31',
            'status' => 'perencanaan', 'is_active' => false, 'notes' => 'Disiapkan untuk penyusunan rencana & budgeting 2027 (Nov–Des 2026).',
        ]);

        $ctx = app(DhastramContext::class);
        $users = (new UserSeeder)->seed($company);

        $ctx->set($company->id, $p2026->id);
        (new EcosystemSeeder)->seed($users);
        (new IdentitySeeder)->seed($users);
        $perf = (new PerformanceSeeder)->seed($users);
        $initiatives = (new ImprovementSeeder)->seed($users, $perf);
        (new ContinuitySeeder)->seed($users, $perf + ['initiatives' => $initiatives]);

        $ctx->set($company->id, $p2027->id);
        (new Planning2027Seeder)->seed($users, $p2026);

        $ctx->clear();
    }
}
