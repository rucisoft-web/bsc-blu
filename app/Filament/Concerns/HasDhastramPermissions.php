<?php

namespace App\Filament\Concerns;

use App\Support\Terms;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

/**
 * Hak akses resource berbasis izin (slug).
 * Resource menetapkan: $viewPermission, $editPermission, $navigationGroupKey (kunci Terms atau label).
 */
trait HasDhastramPermissions
{
    protected static function user(): ?\App\Models\User
    {
        return Auth::user();
    }

    protected static function allows(?string $permission): bool
    {
        if ($permission === null) {
            return true;
        }
        $user = static::user();

        return $user !== null && $user->hasPermission($permission);
    }

    public static function canViewAny(): bool
    {
        return static::allows(static::$viewPermission);
    }

    public static function canView(Model $record): bool
    {
        return static::allows(static::$viewPermission);
    }

    public static function canCreate(): bool
    {
        return static::allows(static::$editPermission);
    }

    public static function canEdit(Model $record): bool
    {
        return static::allows(static::$editPermission);
    }

    public static function canDelete(Model $record): bool
    {
        return static::canEdit($record);
    }

    public static function canDeleteAny(): bool
    {
        return static::allows(static::$editPermission);
    }

    public static function getNavigationGroup(): ?string
    {
        $key = static::$navigationGroupKey ?? null;

        return $key ? (in_array($key, Terms::PHASES, true) ? Terms::get($key) : $key) : null;
    }
}
