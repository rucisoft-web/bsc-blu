<?php

namespace App\Providers\Filament;

use App\Filament\Pages\Auth\EditProfile;
use App\Filament\Pages\Beranda;
use App\Http\Middleware\EnsurePasswordChanged;
use App\Http\Middleware\SetDhastramContext;
use App\Support\Terms;
use Filament\Auth\MultiFactor\App\AppAuthentication;
use Filament\Http\Middleware\Authenticate;
use Filament\Http\Middleware\AuthenticateSession;
use Filament\Http\Middleware\DisableBladeIconComponents;
use Filament\Http\Middleware\DispatchServingFilamentEvent;
use Filament\Navigation\NavigationGroup;
use Filament\Panel;
use Filament\PanelProvider;
use Filament\Support\Colors\Color;
use Filament\View\PanelsRenderHook;
use Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse;
use Illuminate\Cookie\Middleware\EncryptCookies;
use Illuminate\Foundation\Http\Middleware\PreventRequestForgery;
use Illuminate\Routing\Middleware\SubstituteBindings;
use Illuminate\Session\Middleware\StartSession;
use Illuminate\Support\Facades\Blade;
use Illuminate\View\Middleware\ShareErrorsFromSession;

class AdminPanelProvider extends PanelProvider
{
    public function panel(Panel $panel): Panel
    {
        return $panel
            ->default()
            ->id('admin')
            ->path('admin')
            ->login()
            ->passwordReset()
            ->profile(EditProfile::class, isSimple: false)
            ->multiFactorAuthentication(
                [AppAuthentication::make()->recoverable()->brandName(config('dhastram.brand_name'))],
                isRequired: fn (): bool => (bool) config('dhastram.mfa_required')
                    && (bool) auth()->user()?->roles->pluck('slug')->intersect(['super-admin', 'admin-sistem', 'pimpinan', 'pengawas'])->isNotEmpty(),
            )
            ->brandName(config('dhastram.brand_name'))
            ->favicon(asset('favicon.ico'))
            ->colors([
                'primary' => Color::generateV3Palette('#34506E'),  // taum
                'danger' => Color::generateV3Palette('#A8432A'),   // kencu
                'warning' => Color::generateV3Palette('#C08A1E'),
                'success' => Color::generateV3Palette('#4F7A3A'),
                'info' => Color::generateV3Palette('#3F6E8C'),
                'gray' => Color::Stone,
            ])
            ->font('Inter')
            ->sidebarCollapsibleOnDesktop()
            ->databaseNotifications()
            ->databaseNotificationsPolling('60s')
            ->navigationGroups([
                NavigationGroup::make('Umum'),
                NavigationGroup::make(Terms::get('brahman'))->collapsed(),
                NavigationGroup::make(Terms::get('atman'))->collapsed(),
                NavigationGroup::make(Terms::get('karma_phala')),
                NavigationGroup::make(Terms::get('punarbhawa')),
                NavigationGroup::make(Terms::get('moksa'))->collapsed(),
                NavigationGroup::make('Administrasi')->collapsed(),
            ])
            ->discoverResources(in: app_path('Filament/Resources'), for: 'App\Filament\Resources')
            ->discoverPages(in: app_path('Filament/Pages'), for: 'App\Filament\Pages')
            ->pages([Beranda::class])
            ->discoverWidgets(in: app_path('Filament/Widgets'), for: 'App\Filament\Widgets')
            ->widgets([])
            ->renderHook(PanelsRenderHook::TOPBAR_START, fn () => Blade::render('<x-arah.context-badge />'))
            ->renderHook(PanelsRenderHook::FOOTER, fn () => Blade::render('<x-arah.footer />'))
            ->middleware([
                EncryptCookies::class,
                AddQueuedCookiesToResponse::class,
                StartSession::class,
                AuthenticateSession::class,
                ShareErrorsFromSession::class,
                PreventRequestForgery::class,
                SubstituteBindings::class,
                DisableBladeIconComponents::class,
                DispatchServingFilamentEvent::class,
            ])
            ->authMiddleware([
                Authenticate::class,
                SetDhastramContext::class,
                EnsurePasswordChanged::class,
            ]);
    }
}
