<?php

namespace App\Models;

use App\Models\Concerns\Auditable;
use App\Models\Concerns\BelongsToDhastramContext;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Kpi extends Model
{
    use Auditable, BelongsToDhastramContext;

    protected $guarded = ['id'];

    protected static ?string $sequencePrefix = 'KPI';

    public const UNITS = ['Rp juta' => 'Rp juta', 'Rp ribu' => 'Rp ribu', '%' => '%', 'indeks' => 'Indeks', 'skor' => 'Skor', 'kasus' => 'Kasus', 'event' => 'Event', 'unit' => 'Unit', 'hari' => 'Hari', 'jam' => 'Jam', 'menit' => 'Menit', 'rasio' => 'Rasio', 'kali' => 'Kali (x)', 'orang' => 'Orang', 'ribu' => 'Ribu'];

    public const FREQUENCIES = ['bulanan' => 'Bulanan', 'mingguan' => 'Mingguan', 'kuartalan' => 'Kuartalan', 'semesteran' => 'Semesteran', 'tahunan' => 'Tahunan'];

    public const AGGREGATIONS = ['sum' => 'Jumlah (akumulasi)', 'average' => 'Rata-rata', 'last' => 'Nilai terakhir'];

    /** Bulan pelaporan sesuai frekuensi: kuartalan Mar/Jun/Sep/Des, semesteran Jun/Des, tahunan Des. */
    public function isDueIn(int $month): bool
    {
        return match ($this->frequency) {
            'kuartalan' => $month % 3 === 0,
            'semesteran' => $month % 6 === 0,
            'tahunan' => $month === 12,
            default => true,
        };
    }

    protected function casts(): array
    {
        return [
            'is_financial' => 'boolean',
            'is_critical' => 'boolean',
            'is_active' => 'boolean',
            'baseline' => 'float',
            'annual_target' => 'float',
            'weight' => 'float',
        ];
    }

    public function objective(): BelongsTo
    {
        return $this->belongsTo(StrategicObjective::class, 'strategic_objective_id');
    }

    public function owner(): BelongsTo
    {
        return $this->belongsTo(User::class, 'owner_id');
    }

    public function targets(): HasMany
    {
        return $this->hasMany(KpiTarget::class)->orderBy('month');
    }

    public function actuals(): HasMany
    {
        return $this->hasMany(KpiActual::class)->orderBy('month');
    }

    public function getLabelAttribute(): string
    {
        return ($this->short_code ? $this->short_code.' · ' : '').$this->name;
    }

    public function getShortCodeAttribute(): ?string
    {
        return \App\Support\Fmt::shortCode($this->code);
    }

    public function targetFor(int $month): ?float
    {
        $t = $this->relationLoaded('targets') ? $this->targets->firstWhere('month', $month) : $this->targets()->where('month', $month)->first();

        return $t ? (float) $t->target : null;
    }

    public function isOwnedBy(?User $user): bool
    {
        return $user && (int) $this->owner_id === (int) $user->id;
    }
}
