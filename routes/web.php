<?php

use App\Http\Controllers\ReportExportController;
use Illuminate\Support\Facades\Route;

Route::redirect('/', '/admin');

Route::middleware(['web', 'auth', \App\Http\Middleware\SetDhastramContext::class])
    ->get('/admin/laporan/ekspor/{report}', ReportExportController::class)
    ->name('arah.report.export');
