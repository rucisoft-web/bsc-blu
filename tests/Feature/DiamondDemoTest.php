<?php

namespace Tests\Feature;

use App\Models\AnalysisPeriod;
use App\Models\Company;
use App\Models\Kpi;
use App\Models\ObjectiveRelation;
use App\Models\StrategicInitiative;
use App\Models\StrategicObjective;
use App\Services\KpiScoringService;
use App\Support\DhastramContext;
use Tests\TestCase;

class DiamondDemoTest extends TestCase
{
    public function test_demo_command_builds_two_periods_with_a_full_strategy_map(): void
    {
        $this->assertSame(0, $this->artisan('rucibsc:demo-diamond', ['--password' => 'Contoh-2026!', '--force' => true]));
        $this->assertSame(1, $this->artisan('rucibsc:demo-diamond', ['--force' => true])); // data ada, tanpa --reset
        $this->assertSame(0, $this->artisan('rucibsc:demo-diamond', ['--reset' => true, '--force' => true]));

        $company = Company::where('code', 'DFI')->firstOrFail();
        $this->assertTrue((bool) $company->is_demo);
        $periods = AnalysisPeriod::where('company_id', $company->id)->orderBy('year')->get();
        $this->assertSame(['ditutup', 'berjalan'], $periods->pluck('status')->all());
        $this->assertTrue((bool) $periods[1]->is_active);

        app(DhastramContext::class)->set($company->id, $periods[1]->id);
        $this->assertSame(15, StrategicObjective::count());
        $this->assertSame(['C', 'F', 'L', 'P'], StrategicObjective::pluck('code')->map(fn ($c) => $c[0])->unique()->sort()->values()->all());
        $this->assertGreaterThanOrEqual(15, ObjectiveRelation::count());
        $this->assertSame(10, StrategicInitiative::count());

        $scoring = app(KpiScoringService::class);
        $status = Kpi::with('targets', 'actuals')->get()->map(fn ($k) => $scoring->ytd($k)['status'])->countBy();
        $this->assertGreaterThan(0, $status['hijau'] ?? 0);
        $this->assertGreaterThan(0, $status['kuning'] ?? 0);
        $this->assertGreaterThan(0, $status['merah'] ?? 0);
        $this->assertSame(0, $status[''] ?? 0, 'setiap KPI 2026 punya realisasi');
    }
}
