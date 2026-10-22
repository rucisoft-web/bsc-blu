<?php

namespace Database\Seeders;

use App\Models\Permission;
use App\Models\Role;
use App\Support\PermissionCatalog;
use Illuminate\Database\Seeder;

/** Izin & peran sistem DHASTRAM + peran edisi Grand Pasundan (aman dijalankan berulang). */
class DhastramRolePermissionSeeder extends Seeder
{
    public const PERMISSIONS = PermissionCatalog::PERMISSIONS;

    public function run(): void
    {
        foreach (self::PERMISSIONS as $slug => [$group, $name]) {
            Permission::updateOrCreate(['slug' => $slug], ['group' => $group, 'name' => $name]);
        }
        $all = array_keys(self::PERMISSIONS);
        $views = array_values(array_filter($all, fn ($p) => str_ends_with($p, '.view')));
        $except = fn (array $ex) => array_values(array_diff($all, $ex));

        $roles = [
            // ---- peran sistem bawaan DHASTRAM
            'super-admin' => ['Super Admin', 'Konsultan / vendor DHASTRAM — semua izin', $all],
            'company-admin' => ['Company Admin', 'Semua kecuali system.admin', $except(['system.admin'])],
            'strategy-office' => ['Strategy Office', 'Koordinator Manajemen Strategi: semua kecuali system.admin, kpi.approve_actual dan kpi.verify_finance',
                $except(['system.admin', 'kpi.approve_actual', 'kpi.verify_finance'])],
            'management' => ['Management', 'Dasbor, laporan + ekspor, lihat strategi/peta/KPI/inisiatif/tinjauan/temuan/kematangan',
                ['dashboard.view', 'report.view', 'report.export', 'strategy.view', 'strategy.map', 'kpi.view', 'initiative.view', 'review.view', 'finding.view', 'maturity.view', 'context.switch']],
            'kpi-owner' => ['KPI Owner', 'Mengisi realisasi KPI miliknya', ['dashboard.view', 'kpi.view', 'kpi.input_actual', 'context.switch']],
            'initiative-pic' => ['Initiative PIC', 'Memperbarui progres inisiatif miliknya (+ melihat temuan)', ['dashboard.view', 'initiative.view', 'initiative.update_progress', 'finding.view', 'context.switch']],
            'reviewer' => ['Reviewer', 'Tinjauan kinerja & temuan', ['dashboard.view', 'review.view', 'review.edit', 'finding.view', 'maturity.view', 'context.switch']],
            'viewer' => ['Viewer', 'Baca-saja', array_merge($views, ['strategy.map', 'context.switch'])],
            // ---- peran edisi Grand Pasundan
            'gpch-admin-sistem' => ['GPCH Admin Sistem', 'EDP / IT Manager: akun pengguna, peran, reset kata sandi',
                array_merge(['system.admin', 'audit.view', 'dashboard.view', 'report.view', 'context.switch', 'strategy.map', 'initiative.update_progress'], $views)],
            'gpch-pengawas' => ['GPCH Tim Pengawas', 'Ketua Tim Pengawas: baca semua, catatan pengawasan & membuat temuan',
                array_merge($views, ['strategy.map', 'report.view', 'report.export', 'audit.view', 'review.note', 'finding.create', 'context.switch'])],
            'gpch-gm' => ['GPCH General Manager', 'Semua kecuali system.admin; menyetujui realisasi & menutup temuan', $except(['system.admin'])],
            'gpch-keuangan' => ['GPCH Keuangan', 'Chief Accountant: KPI keuangan, verifikasi, realisasi anggaran',
                ['dashboard.view', 'report.view', 'report.export', 'strategy.view', 'strategy.map', 'kpi.view', 'kpi.input_actual', 'kpi.verify_finance',
                    'initiative.view', 'initiative.budget', 'initiative.update_progress', 'review.view', 'finding.view', 'finding.edit', 'context.switch']],
            'gpch-kepala-dept' => ['GPCH Kepala Departemen', 'Input realisasi KPI & progres inisiatif miliknya, tindakan korektif miliknya',
                ['dashboard.view', 'strategy.view', 'strategy.map', 'brahman.view', 'atman.view', 'kpi.view', 'kpi.input_actual', 'initiative.view',
                    'initiative.update_progress', 'review.view', 'finding.view', 'finding.edit', 'maturity.view', 'report.view', 'context.switch']],
            'gpch-editor-ekosistem' => ['GPCH Editor Ekosistem', 'Tambahan: mengubah data Ekosistem (pasar, pesaing, isu)', ['brahman.view', 'brahman.edit']],
            'gpch-editor-jatidiri' => ['GPCH Editor Jati Diri', 'Tambahan: mengubah Jati Diri (kapabilitas, nilai inti)', ['atman.view', 'atman.edit']],
            'gpch-pelaksana' => ['GPCH Pelaksana', 'Supervisor/staf: input data atas nama departemen',
                ['dashboard.view', 'kpi.view', 'kpi.input_actual', 'initiative.view', 'initiative.update_progress', 'context.switch']],
        ];
        foreach ($roles as $slug => [$name, $desc, $perms]) {
            $role = Role::updateOrCreate(['slug' => $slug], ['name' => $name, 'description' => $desc, 'is_system' => true]);
            $role->permissions()->sync(Permission::whereIn('slug', $perms)->pluck('id'));
        }
    }
}
