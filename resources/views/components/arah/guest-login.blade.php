@if (\App\Support\GuestMode::enabled())
    <div class="arah-guest-login">
        <div class="arah-guest-or"><span>atau</span></div>
        <a href="{{ route('arah.guest') }}" class="arah-guest-btn">Masuk sebagai Tamu (lihat-lihat)</a>
        <a href="{{ route('arah.kenali') }}" class="arah-guest-learn">Kenali dulu apa itu Ruci BSC →</a>
        <p>Jelajahi contoh Diamond Food, Hermina, Medco, Pakuwon, Kimia Farma, Semen Indonesia, MAP, GoTo, Astra, BCA, Telkom, Blue Bird, dan SMBC Indonesia tanpa akun. Mode Tamu hanya melihat, data contoh tidak bisa diubah.</p>
        <p class="arah-demo-note"><b>Data demo:</b> disusun untuk pembelajaran dan secara garis besar mengacu pada laporan tahunan masing-masing perusahaan. Target dan data 2026 adalah simulasi, bukan data resmi perusahaan.</p>
    </div>
@endif
