<?php

namespace App\Support;

class Fmt
{
    public static function num(float|int|string|null $v, int $dec = 0): string
    {
        if ($v === null || $v === '') {
            return '-';
        }

        return number_format((float) $v, $dec, ',', '.');
    }

    public static function rp(float|int|string|null $v): string
    {
        return $v === null ? '-' : 'Rp '.number_format((float) $v, 0, ',', '.');
    }

    public static function pct(float|int|null $v, int $dec = 1): string
    {
        return $v === null ? '-' : number_format((float) $v, $dec, ',', '.').'%';
    }

    public static function kpiValue(float|int|string|null $v, ?string $unit, int $dec = 0): string
    {
        if ($v === null) {
            return '-';
        }
        $n = self::num($v, $dec);

        return match ($unit) {
            '%' => $n.'%',
            'Rp juta' => 'Rp '.$n.' jt',
            'Rp ribu' => 'Rp '.$n.' rb',
            default => $n.($unit ? ' '.$unit : ''),
        };
    }

    /** OBJ/DFI/2026/001 -> OBJ-001 */
    public static function shortCode(?string $code): ?string
    {
        if (! $code) {
            return null;
        }
        $parts = explode('/', $code);

        return count($parts) >= 4 ? $parts[0].'-'.end($parts) : $code;
    }

    public static function statusColor(?string $status): string
    {
        return match ($status) {
            'hijau' => 'success',
            'kuning' => 'warning',
            'merah' => 'danger',
            default => 'gray',
        };
    }

    public static function statusHex(?string $status): string
    {
        return match ($status) {
            'hijau' => '#4F7A3A',
            'kuning' => '#C08A1E',
            'merah' => '#A8432A',
            default => '#9A8F80',
        };
    }
}
