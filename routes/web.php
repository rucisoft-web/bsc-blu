<?php

use App\Http\Controllers\ReportExportController;
use Illuminate\Support\Facades\Route;

Route::redirect('/', '/admin');

Route::middleware(['web', 'auth', \App\Http\Middleware\SetDhastramContext::class])
    ->get('/admin/laporan/ekspor/{report}', ReportExportController::class)
    ->name('arah.report.export');

// Situs demo: masuk sebagai Tamu (hanya lihat), aktif bila RUCI_GUEST_LOGIN=true
Route::middleware(['web', 'throttle:20,1'])
    ->get('/masuk-tamu', \App\Http\Controllers\GuestLoginController::class)
    ->name('arah.guest');
