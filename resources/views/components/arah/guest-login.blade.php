@if (\App\Support\GuestMode::enabled())
    <div class="arah-guest-login">
        <div class="arah-guest-or"><span>atau</span></div>
        <a href="{{ route('arah.guest') }}" class="arah-guest-btn">Masuk sebagai Tamu (lihat-lihat)</a>
        <a href="{{ route('arah.kenali') }}" class="arah-guest-learn">Kenali dulu apa itu Ruci BSC →</a>
        <p>Jelajahi contoh Diamond Food dan Hermina tanpa akun. Mode Tamu hanya melihat, data contoh tidak bisa diubah.</p>
    </div>
@endif
