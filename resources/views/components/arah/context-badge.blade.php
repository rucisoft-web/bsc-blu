@php
    $ctx = app(\App\Support\DhastramContext::class);
    $company = $ctx->company();
    $period = $ctx->period();
@endphp
@if ($company && $period)
    <a href="{{ \App\Filament\Pages\PilihKonteks::getUrl() }}" class="arah-context" title="Pilih perusahaan & perioda">
        <span class="arah-dot" style="background: {{ $period->status === 'berjalan' ? '#4F7A3A' : '#B8862B' }}"></span>
        {{ $company->code }} · {{ $period->name }}
        @if ($period->status !== 'berjalan') <span style="font-weight:500">({{ $period->status }})</span> @endif
    </a>
@endif
