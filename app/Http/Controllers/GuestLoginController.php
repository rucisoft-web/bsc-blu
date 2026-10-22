<?php

namespace App\Http\Controllers;

use App\Models\AnalysisPeriod;
use App\Support\DhastramContext;
use App\Support\GuestMode;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

/** Masuk sebagai Tamu (hanya lihat) dengan satu klik dari halaman login situs demo. */
class GuestLoginController extends Controller
{
    public function __invoke(Request $request)
    {
        abort_unless(GuestMode::enabled(), 404);

        if (Auth::check()) {
            Auth::logout();
        }
        Auth::login(GuestMode::user());
        $request->session()->regenerate();

        if ($company = GuestMode::startCompany()) {
            $periodId = AnalysisPeriod::where('company_id', $company->id)->orderByDesc('is_active')->orderByDesc('year')->value('id');
            if ($periodId) {
                app(DhastramContext::class)->switch($company->id, $periodId);
            }
        }

        return redirect('/admin');
    }
}
