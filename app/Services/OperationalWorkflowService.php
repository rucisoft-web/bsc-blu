<?php

namespace App\Services;

use App\Models\CorrectiveAction;
use App\Models\InitiativeActivity;
use App\Models\Kpi;
use App\Models\KpiActual;
use App\Models\PerformanceReview;
use App\Support\DhastramContext;
use App\Support\Terms;

/** Panduan alur kerja: ritme harian/mingguan/bulanan dan status siklus bulan berjalan. */
class OperationalWorkflowService
{
    public function __construct(protected DhastramContext $ctx) {}

    public function rhythm(): array
    {
        $c = config('dhastram.cycle');

        return [
            ['ritme' => 'Harian', 'kegiatan' => 'Cek Beranda dan Pusat Kendali; perbarui aktivitas inisiatif yang bergerak', 'pelaku' => 'GM, kepala departemen', 'batas' => '—'],
            ['ritme' => 'Mingguan', 'kegiatan' => 'Perbarui progres aktivitas & milestone; isi realisasi mingguan KPI pendapatan, okupansi, ARR, banquet dari VHP', 'pelaku' => 'PIC inisiatif, Sales, Chief Accountant', 'batas' => 'Senin 10.00, sebelum weekly report'],
            ['ritme' => 'Mingguan', 'kegiatan' => 'Catat GM Weekly Report sebagai Tinjauan Kinerja; buat temuan dan tindakan korektif baru', 'pelaku' => 'GM / Koordinator Manajemen Strategi', 'batas' => 'Senin'],
            ['ritme' => 'Bulanan', 'kegiatan' => 'Input realisasi semua KPI bulan lalu', 'pelaku' => 'Pemilik KPI', 'batas' => 'tanggal '.$c['input_day']],
            ['ritme' => 'Bulanan', 'kegiatan' => 'Verifikasi angka keuangan dengan laporan VHP', 'pelaku' => 'Chief Accountant', 'batas' => 'tanggal '.$c['verify_day']],
            ['ritme' => 'Bulanan', 'kegiatan' => 'Setujui realisasi; KPI terkunci', 'pelaku' => 'GM', 'batas' => 'tanggal '.$c['approve_day']],
            ['ritme' => 'Bulanan', 'kegiatan' => 'Rapat manajemen: tinjau sasaran merah/kuning, tutup temuan selesai, ekspor laporan', 'pelaku' => 'GM, semua kepala departemen', 'batas' => 'tanggal '.$c['meeting_day']],
            ['ritme' => 'Bulanan / kuartalan', 'kegiatan' => 'Laporan ke Tim Pengawas; catatan pengawasan dan temuan Timwas', 'pelaku' => 'Ketua Timwas', 'batas' => 'setelah rapat manajemen'],
            ['ritme' => 'Kuartalan', 'kegiatan' => 'Tinjau portofolio inisiatif (kuadran Tinjau Ulang), perbarui isu Ekosistem dan risiko', 'pelaku' => 'GM, Koordinator Manajemen Strategi', 'batas' => 'akhir kuartal'],
            ['ritme' => 'Tahunan', 'kegiatan' => 'Penilaian kematangan; susun perioda baru: '.Terms::get('brahman').' → '.Terms::get('atman').' → sasaran, target, inisiatif', 'pelaku' => 'GM, semua kepala departemen, Timwas', 'batas' => 'Nov–Des'],
        ];
    }

    /** Status siklus bulanan untuk bulan realisasi terakhir. */
    public function cycle(): array
    {
        $month = $this->ctx->lastClosedMonth();
        $kpiCount = Kpi::where('is_active', true)->count();
        $actuals = $month ? KpiActual::where('month', $month)->get() : collect();
        $financial = Kpi::where('is_active', true)->where('is_financial', true)->pluck('id');
        $finActuals = $actuals->whereIn('kpi_id', $financial);

        return [
            'month' => $month,
            'month_label' => $month ? Terms::months()[$month] : '-',
            'steps' => [
                ['label' => 'Realisasi terisi', 'done' => $actuals->count(), 'total' => $kpiCount],
                ['label' => 'KPI keuangan terverifikasi', 'done' => $finActuals->whereIn('status', ['terverifikasi', 'disetujui'])->count(), 'total' => $financial->count()],
                ['label' => 'Realisasi disetujui GM', 'done' => $actuals->where('status', 'disetujui')->count(), 'total' => $kpiCount],
            ],
            'returned' => $actuals->where('status', 'dikembalikan')->count(),
            'reviews_this_month' => PerformanceReview::whereYear('review_date', now()->year)->whereMonth('review_date', now()->month)->count(),
            'overdue_actions' => CorrectiveAction::where('status', '!=', 'selesai')->whereDate('due_date', '<', today())->count(),
            'overdue_activities' => InitiativeActivity::where('status', 'terlambat')->count(),
        ];
    }
}
