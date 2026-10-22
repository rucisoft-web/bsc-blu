<?php

namespace App\Console\Commands;

use App\Models\AuditLog;
use App\Models\Company;
use App\Models\User;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

/**
 * Cutover edisi Grand Pasundan: hapus perusahaan lain & akun demo, ganti kode GPCH-DEMO → GPCH,
 * kosongkan log audit. Selalu meminta konfirmasi dan membuat cadangan JSON terlebih dahulu.
 */
class GpchCutover extends Command
{
    protected $signature = 'dhastram:gpch-cutover {--keep=GPCH : Kode perusahaan yang dipertahankan} {--force : Lewati konfirmasi}';

    protected $description = 'Cutover edisi GPCH: bersihkan data demo & siapkan go-live';

    public function handle(): int
    {
        $keep = strtoupper($this->option('keep'));
        $company = Company::whereIn('code', [$keep, $keep.'-DEMO'])->first();
        if (! $company) {
            $this->error("Perusahaan {$keep} / {$keep}-DEMO tidak ditemukan.");

            return self::FAILURE;
        }
        $others = Company::where('id', '!=', $company->id)->get();
        $demoUsers = User::where(fn ($q) => $q->where('email', 'like', '%@grandpasundan.demo')->orWhere('email', 'like', '%@dhastram.local')->orWhere('email', 'like', '%.demo'))->get();
        $this->line("Dipertahankan : {$company->code} — {$company->name}");
        $this->line('Dihapus       : '.$others->count().' perusahaan lain ('.$others->pluck('code')->join(', ').'), '.$demoUsers->count().' akun demo');
        $this->line('Log audit     : '.AuditLog::count().' baris akan dikosongkan');
        if (! $this->option('force') && ! $this->confirm('Lanjutkan cutover? Cadangan JSON dibuat lebih dulu.', false)) {
            return self::FAILURE;
        }

        $backup = $this->backup();
        $this->info('Cadangan: '.$backup);

        DB::transaction(function () use ($company, $others, $demoUsers, $keep) {
            foreach ($others as $o) {
                $o->delete(); // cascade ke seluruh data perusahaan
            }
            foreach ($demoUsers as $u) {
                $u->roles()->detach();
                $u->delete();
            }
            if ($company->code !== $keep) {
                $old = $company->code;
                $company->update(['code' => $keep]);
                // perbarui kode dokumen OBJ/GPCH-DEMO/2026/001 -> OBJ/GPCH/2026/001
                foreach (Schema::getTables() as $t) {
                    $name = $t['name'];
                    if (Schema::hasColumn($name, 'code') && Schema::hasColumn($name, 'company_id')) {
                        DB::table($name)->where('company_id', $company->id)->where('code', 'like', '%/'.$old.'/%')
                            ->update(['code' => DB::raw("REPLACE(code, '/{$old}/', '/{$keep}/')")]);
                    }
                }
            }
            DB::table('audit_logs')->delete();
            DB::table('notifications')->delete();
        });
        $this->info('Cutover selesai. Lanjutkan: php artisan dhastram:create-admin · buat akun nyata · php artisan optimize');

        return self::SUCCESS;
    }

    protected function backup(): string
    {
        $dir = storage_path('app/private/backups');
        @mkdir($dir, 0775, true);
        $file = $dir.'/cutover_'.now()->format('Ymd_His').'.json';
        $data = [];
        foreach (Schema::getTables() as $t) {
            $data[$t['name']] = DB::table($t['name'])->get();
        }
        file_put_contents($file, json_encode($data, JSON_UNESCAPED_UNICODE));

        return $file;
    }
}
