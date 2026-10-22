<?php

namespace Database\Seeders\Gpch;

use App\Models\AnalysisPeriod;
use App\Models\AtmanProfile;
use App\Models\CoreValue;
use App\Models\EnvironmentScan;
use App\Models\StrategicTheme;
use App\Support\DhastramContext;

/** Perioda 2027 disiapkan untuk perencanaan: jati diri & tema disalin sebagai draf, agenda budgeting dicatat. */
class Planning2027Seeder
{
    public function seed(array $u, AnalysisPeriod $from): void
    {
        $ctx = app(DhastramContext::class);
        [$profile, $values, $themes] = $ctx->withoutScope(fn () => [
            AtmanProfile::where('analysis_period_id', $from->id)->first(),
            CoreValue::where('analysis_period_id', $from->id)->orderBy('sort')->get(),
            StrategicTheme::where('analysis_period_id', $from->id)->orderBy('sort')->get(),
        ]);
        if ($profile) {
            AtmanProfile::create(collect($profile->getAttributes())->except(['id', 'company_id', 'analysis_period_id', 'created_at', 'updated_at', 'approved_by', 'approved_at'])->all());
        }
        foreach ($values as $v) {
            CoreValue::create(collect($v->getAttributes())->except(['id', 'company_id', 'analysis_period_id', 'created_at', 'updated_at'])->all());
        }
        foreach ($themes as $t) {
            StrategicTheme::create(collect($t->getAttributes())->except(['id', 'company_id', 'analysis_period_id', 'created_at', 'updated_at', 'code'])->all()
                + ['description' => $t->description.' (draf 2027 — tinjau ulang)']);
        }
        foreach ([
            ['Agenda budgeting 2027 — pameran & travel mart', '2026-10-02', 'eksternal', 'GM Weekly Report Sep 2026 — Sales & Marketing Plan',
                'Heritage Wedding Bride Expo 2027 (Lintas Warna EO) 9–10 Jan 2027 di Grand Sudirman Ballroom, est. Rp13 jt; Superstar Wedding Exhibition (WA Wedding Planner) 26–27 Jun 2027, Rp15 jt; Lare Table Top Jogja Business Matching 19–21 Jan, Rp5,5 jt/delegate; ASITA West Java Travel Mart Bandung (TBA Sep 2027), Rp6 jt/delegate.',
                'Masukkan ke anggaran marketing 2027 & inisiatif kemitraan TA/EO.'],
            ['Kerangka penyusunan rencana 2027', '2026-10-17', 'internal', 'Spesifikasi Arah GPCH',
                'Urutan: Ekosistem → Jati Diri → sasaran, target, inisiatif. Data budgeting tiap departemen dikumpulkan (format streaming account, SWOT, expenses).',
                'Penilaian kematangan Nov–Des 2026 menjadi masukan rencana 2027.'],
        ] as [$title, $date, $scope, $source, $summary, $impl]) {
            EnvironmentScan::create(compact('title', 'scope', 'source', 'summary') + ['scan_date' => $date, 'implications' => $impl, 'status' => 'aktif', 'created_by' => $u['koordinator']->id]);
        }
    }
}
