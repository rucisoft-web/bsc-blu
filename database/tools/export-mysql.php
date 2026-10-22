<?php
/**
 * Membuat dump MySQL (database/sql/arahgpch.sql) dari basis data yang sedang dipakai (mis. SQLite hasil seeding)
 * memakai grammar MySQL Laravel. DDL dihasilkan dalam mode "pretend" dari file migrasi yang sama.
 *
 * Pemakaian:  php database/tools/export-mysql.php [output.sql]
 */
require __DIR__.'/../../vendor/autoload.php';
$app = require __DIR__.'/../../bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use Illuminate\Database\MySqlConnection;
use Illuminate\Support\Facades\DB;

$out = $argv[1] ?? __DIR__.'/../sql/arahgpch.sql';
@mkdir(dirname($out), 0775, true);

// 1) DDL: jalankan migrasi dalam mode pretend dengan koneksi bergrammar MySQL (tanpa server)
$config = ['driver' => 'mysql', 'database' => 'arahgpch', 'prefix' => '', 'charset' => 'utf8mb4', 'collation' => 'utf8mb4_unicode_ci', 'engine' => 'InnoDB', 'name' => 'mysqlddl'];
$pdo = new PDO('sqlite::memory:');
$conn = new class($pdo, 'arahgpch', '', $config) extends MySqlConnection {
    public function getServerVersion(): string { return '8.0.36'; }
    public function isMaria(): bool { return false; }
};
DB::extend('mysqlddl', fn () => $conn);
config(['database.connections.mysqlddl' => $config + ['driver' => 'mysqlddl']]);
$manager = app('db');
$prevDefault = $manager->getDefaultConnection();
$manager->setDefaultConnection('mysqlddl');
$ddl = [];
$files = glob(database_path('migrations/*.php'));
sort($files);
foreach ($files as $file) {
    $migration = require $file;
    $queries = $conn->pretend(fn () => $migration->up());
    foreach ($queries as $q) {
        $sql = $q['query'];
        foreach ($q['bindings'] as $b) {
            $sql = preg_replace('/\?/', is_numeric($b) ? $b : "'".addslashes($b)."'", $sql, 1);
        }
        $ddl[] = $sql.';';
    }
}
$manager->setDefaultConnection($prevDefault);
$ddl = array_merge([
    'create table `migrations` (`id` int unsigned not null auto_increment primary key, `migration` varchar(255) not null, `batch` int not null) default character set utf8mb4 collate \'utf8mb4_unicode_ci\' engine = InnoDB;',
], $ddl);

// 2) Data dari koneksi aktif
$src = DB::connection($prevDefault);
$tables = collect($src->getSchemaBuilder()->getTables())->pluck('name')
    ->reject(fn ($t) => in_array($t, ['sqlite_sequence', 'cache', 'cache_locks', 'sessions', 'jobs', 'job_batches', 'failed_jobs', 'password_reset_tokens'], true))->values();
$quote = function ($v) use ($pdo) {
    if ($v === null) return 'NULL';
    if (is_bool($v)) return $v ? '1' : '0';
    if (is_int($v) || is_float($v)) return (string) $v;
    return "'".str_replace(["\\", "'", "\r", "\n", "\0"], ["\\\\", "\\'", "\\r", "\\n", "\\0"], (string) $v)."'";
};
$lines = [];
$lines[] = '-- Arah GPCH — dump MySQL/MariaDB';
$lines[] = '-- Dibuat: '.now()->format('Y-m-d H:i:s').' (Asia/Jakarta) dari data awal Grand Pasundan Convention Hotel';
$lines[] = '-- Impor: buat database `arahgpch` (utf8mb4_unicode_ci) lalu jalankan file ini (HeidiSQL / phpMyAdmin / mysql CLI).';
$lines[] = '';
$lines[] = 'SET NAMES utf8mb4;';
$lines[] = "SET time_zone = '+07:00';";
$lines[] = 'SET FOREIGN_KEY_CHECKS = 0;';
$lines[] = "SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';";
$lines[] = '';
$dropOrder = array_reverse(array_merge(['migrations'], $tables->all()));
foreach (array_unique(array_merge($dropOrder, ['cache', 'cache_locks', 'sessions', 'jobs', 'job_batches', 'failed_jobs', 'password_reset_tokens', 'notifications'])) as $t) {
    $lines[] = 'DROP TABLE IF EXISTS `'.$t.'`;';
}
$lines[] = '';
$lines[] = '-- ---------------- Struktur tabel';
foreach ($ddl as $s) {
    $lines[] = $s;
}
$lines[] = '';
$lines[] = '-- ---------------- Data';
$rows = 0;
foreach ($tables as $t) {
    $data = $src->table($t)->get();
    if ($data->isEmpty()) continue;
    $cols = array_keys((array) $data->first());
    $lines[] = '';
    $lines[] = '-- '.$t.' ('.$data->count().' baris)';
    foreach ($data->chunk(100) as $chunk) {
        $vals = $chunk->map(fn ($r) => '('.implode(', ', array_map($quote, array_values((array) $r))).')')->join(",\n");
        $lines[] = 'INSERT INTO `'.$t.'` (`'.implode('`, `', $cols).'`) VALUES'."\n".$vals.';';
    }
    $rows += $data->count();
}
$lines[] = '';
$lines[] = 'SET FOREIGN_KEY_CHECKS = 1;';
file_put_contents($out, implode("\n", $lines)."\n");
echo 'Ditulis: '.$out.' — '.count($ddl).' perintah DDL, '.$tables->count().' tabel, '.$rows." baris data\n";
