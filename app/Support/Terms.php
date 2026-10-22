<?php

namespace App\Support;

class Terms
{
    public const PERSPECTIVES = ['keuangan', 'pelanggan', 'proses', 'sdm'];

    public const PHASES = ['brahman', 'atman', 'karma_phala', 'punarbhawa', 'moksa'];

    public static function get(string $key): string
    {
        $dict = config('dhastram.dictionaries.'.config('dhastram.terms', 'umum'), []);

        return $dict[$key] ?? $key;
    }

    /** @return array<string,string> */
    public static function perspectives(): array
    {
        return collect(self::PERSPECTIVES)->mapWithKeys(fn ($p) => [$p => self::get($p)])->all();
    }

    /** @return array<string,string> */
    public static function phases(): array
    {
        return collect(self::PHASES)->mapWithKeys(fn ($p) => [$p => self::get($p)])->all();
    }

    public static function perspective(?string $key): string
    {
        return $key ? self::get($key) : '-';
    }

    public static function perspectiveColor(?string $key): string
    {
        return match ($key) {
            'keuangan' => '#A8432A',
            'pelanggan' => '#B8862B',
            'proses' => '#34506E',
            'sdm' => '#4F6B3A',
            default => '#6B5E4F',
        };
    }

    public static function months(): array
    {
        return [1 => 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    }

    public static function monthShort(int $m): string
    {
        return ['', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'][$m] ?? (string) $m;
    }
}
