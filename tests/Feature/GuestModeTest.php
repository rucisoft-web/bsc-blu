<?php

namespace Tests\Feature;

use App\Filament\Resources\Kpis\KpiResource;
use App\Models\Company;
use App\Models\User;
use App\Models\UserContext;
use App\Support\GuestMode;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Tests\TestCase;

class GuestModeTest extends TestCase
{
    public function test_guest_entry_is_hidden_when_disabled(): void
    {
        config(['dhastram.guest_login' => false]);

        $this->get('/masuk-tamu')->assertNotFound();
        $this->get('/admin/login')->assertOk()->assertDontSee('Masuk sebagai Tamu');
        $this->assertNull(User::where('email', GuestMode::email())->first());
    }

    public function test_one_click_guest_login_opens_the_demo_read_only(): void
    {
        config(['dhastram.guest_login' => true]);
        [$other] = $this->company('AAA');
        [$dfi, $period] = $this->company('DFI');

        $this->get('/admin/login')->assertOk()->assertSee('Masuk sebagai Tamu');
        $this->get('/masuk-tamu')->assertRedirect('/admin');

        $guest = User::where('email', GuestMode::email())->firstOrFail();
        $this->assertAuthenticatedAs($guest);
        $this->assertTrue($guest->isGuestVisitor());
        $this->assertSame($dfi->id, session('dhastram.company_id'));
        $this->assertSame($period->id, session('dhastram.period_id'));
        $this->assertSame(0, UserContext::where('user_id', $guest->id)->count(), 'konteks Tamu hanya di sesi');
        $this->assertEqualsCanonicalizing([$other->id, $dfi->id], $guest->accessibleCompanyIds());

        $this->get('/admin')->assertOk()->assertSee('Mode Tamu');

        // masuk lagi tidak menggandakan akun/peran
        $this->get('/masuk-tamu')->assertRedirect('/admin');
        $this->assertSame(1, User::where('email', GuestMode::email())->count());
        $this->assertSame(1, $guest->fresh()->roles()->count());
    }

    public function test_guest_can_view_but_never_change_data(): void
    {
        config(['dhastram.guest_login' => true]);
        [$company, $period] = $this->company('DFI');
        $guest = GuestMode::user();
        $this->actingAs($guest);
        $this->useContext($period);

        $this->assertTrue($guest->hasPermission('kpi.view'));
        $this->assertTrue($guest->hasPermission('strategy.map'));
        foreach (['kpi.edit', 'kpi.input_actual', 'report.export', 'audit.view', 'system.admin'] as $perm) {
            $this->assertFalse($guest->hasPermission($perm), $perm);
        }
        $this->assertTrue(KpiResource::canViewAny());
        $this->assertFalse(KpiResource::canCreate());

        $this->assertBlocked(fn () => $company->update(['name' => 'Diubah tamu']));
        $this->assertBlocked(fn () => Company::create(['code' => 'XXX', 'name' => 'Baru', 'is_active' => true]));
        $this->assertBlocked(fn () => $company->delete());
        $this->assertBlocked(fn () => $guest->update(['name' => 'Ganti nama']));
        $this->assertSame('PT DFI', $company->fresh()->name);

        // pemeliharaan sesi tetap jalan
        $guest->refresh()->forceFill(['remember_token' => 'abc'])->save();
        $this->assertSame('abc', $guest->fresh()->remember_token);
    }

    public function test_regular_users_are_not_affected(): void
    {
        [$company, $period] = $this->company('DFI');
        $admin = $this->user('admin@dfi.test', 'company-admin', $company);
        $this->actingAs($admin);
        $this->useContext($period);

        $company->update(['name' => 'PT Diamond']);
        $this->assertSame('PT Diamond', $company->fresh()->name);
        $this->assertFalse($admin->isGuestVisitor());
    }

    private function assertBlocked(callable $write): void
    {
        try {
            $write();
            $this->fail('penulisan oleh Tamu seharusnya ditolak');
        } catch (HttpException $e) {
            $this->assertSame(403, $e->getStatusCode());
        }
    }
}
