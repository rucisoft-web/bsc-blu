<?php

namespace Database\Seeders\Gpch;

use App\Models\Company;
use App\Models\Role;
use App\Models\User;
use App\Models\UserContext;
use Illuminate\Support\Facades\Hash;

/**
 * Akun per jabatan. Nama diambil dari MoM 23 Sep 2026 & GM Weekly Report (tanda tangan HOD).
 * Email @grandpasundanhotel.com bersifat usulan — konfirmasi dengan HR sebelum go-live.
 * Semua akun wajib mengganti kata sandi saat login pertama.
 */
class UserSeeder
{
    public const DEFAULT_PASSWORD = 'GPCH-2026!ganti';

    public const ADMIN_PASSWORD = 'Arah@GPCH2026';

    /** @return array<string,User> */
    public function seed(Company $company): array
    {
        $rows = [
            // key => [nama, email, jabatan, departemen, [peran]]
            'admin' => ['Konsultan DHASTRAM', 'admin@arahgpch.local', 'Konsultan / vendor DHASTRAM', 'Konsultan', ['super-admin']],
            'edp' => ['Admin EDP GPCH (isi nama)', 'edp@grandpasundanhotel.com', 'EDP / IT Manager', 'EDP', ['gpch-admin-sistem']],
            'wilfred' => ['Bapak Wilfred', 'wilfred@grandpasundanhotel.com', 'Ketua Tim Pengawas', 'Tim Pengawas', ['gpch-pengawas']],
            'gm' => ['Ibu Vivera', 'gm@grandpasundanhotel.com', 'General Manager', 'Executive Office', ['gpch-gm']],
            'koordinator' => ['Koordinator Manajemen Strategi (isi nama)', 'strategi@grandpasundanhotel.com', 'Koordinator Manajemen Strategi (staf GM)', 'Executive Office', ['strategy-office']],
            'ca' => ['Bapak Indra', 'ca@grandpasundanhotel.com', 'Chief Accountant', 'Accounting', ['gpch-keuangan']],
            'sales' => ['Ibu Irina', 'sales@grandpasundanhotel.com', 'Sales & Marketing Manager', 'Sales & Marketing', ['gpch-kepala-dept', 'gpch-editor-ekosistem']],
            'fom' => ['Bapak Rizki', 'fom@grandpasundanhotel.com', 'Front Office Manager', 'Front Office', ['gpch-kepala-dept']],
            'fbm' => ['Bapak Asep Agus Damil Arifin', 'fbm@grandpasundanhotel.com', 'F&B Manager / Executive Chef', 'Food & Beverage', ['gpch-kepala-dept']],
            'ce' => ['Bapak Wahyudin', 'engineering@grandpasundanhotel.com', 'Chief Engineer (Plt.)', 'Engineering', ['gpch-kepala-dept']],
            'ehk' => ['Ibu Wina', 'hk@grandpasundanhotel.com', 'Executive Housekeeper (Plt.)', 'Housekeeping', ['gpch-kepala-dept']],
            'hrm' => ['Bapak Anto', 'hrd@grandpasundanhotel.com', 'HR Manager', 'Human Resources', ['gpch-kepala-dept', 'gpch-editor-jatidiri']],
            'purchasing' => ['Bapak Daniel', 'purchasing@grandpasundanhotel.com', 'Purchasing', 'Accounting', ['gpch-kepala-dept']],
            // pelaksana
            'rika' => ['Ibu Rika', 'rika.sales@grandpasundanhotel.com', 'Sales Executive', 'Sales & Marketing', ['gpch-pelaksana']],
            'arsy' => ['Arsy', 'arsy.sales@grandpasundanhotel.com', 'Sales Executive', 'Sales & Marketing', ['gpch-pelaksana']],
            'ihsan' => ['Muhamad Ihsan', 'fo.supervisor@grandpasundanhotel.com', 'Front Office Supervisor', 'Front Office', ['gpch-pelaksana']],
            'ujang' => ['Ujang Nur M', 'hk.supervisor@grandpasundanhotel.com', 'Housekeeping Supervisor', 'Housekeeping', ['gpch-pelaksana']],
            'rara' => ['Rara', 'eng.admin@grandpasundanhotel.com', 'Engineering Admin', 'Engineering', ['gpch-pelaksana']],
            // baca-saja
            'wimpy' => ['Bapak Wimpy', 'owner@grandpasundanhotel.com', 'Pemilik', 'Pemilik', ['viewer']],
            'yodi' => ['Bapak Yodi S. Ibrahim', 'yodi@grandpasundanhotel.com', 'Direksi', 'Direksi', ['management']],
            'miko' => ['Bapak Miko', 'miko@grandpasundanhotel.com', 'Anggota Tim Pengawas', 'Tim Pengawas', ['viewer']],
            'joice' => ['Bapak Joice', 'joice@grandpasundanhotel.com', 'Anggota Tim Pengawas', 'Tim Pengawas', ['viewer']],
            'yuli' => ['Ibu Yuli', 'yuli@grandpasundanhotel.com', 'Anggota Tim Pengawas', 'Tim Pengawas', ['viewer']],
            'wiwin' => ['Bapak I.G. Wiwin Suyasa', 'wiwin@visiperencana.id', 'Auditor Operasional (Visi Perencana Indonesia)', 'Eksternal', ['viewer']],
        ];
        $out = [];
        foreach ($rows as $key => [$name, $email, $title, $dept, $roles]) {
            $user = User::updateOrCreate(['email' => $email], [
                'name' => $name, 'job_title' => $title, 'department' => $dept, 'is_active' => true,
                'password' => Hash::make($key === 'admin' ? self::ADMIN_PASSWORD : self::DEFAULT_PASSWORD),
                'must_change_password' => $key !== 'admin',
                'email_verified_at' => now(),
            ]);
            $user->companies()->syncWithoutDetaching([$company->id]);
            foreach ($roles as $slug) {
                $role = Role::where('slug', $slug)->firstOrFail();
                $companyId = $slug === 'super-admin' ? null : $company->id; // peran per perusahaan, kecuali super admin
                if (! $user->roles()->where('roles.id', $role->id)->wherePivot('company_id', $companyId)->exists()) {
                    $user->roles()->attach($role->id, ['company_id' => $companyId]);
                }
            }
            UserContext::updateOrCreate(['user_id' => $user->id], ['company_id' => $company->id, 'analysis_period_id' => null]);
            $out[$key] = $user;
        }

        return $out;
    }
}
