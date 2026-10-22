<x-filament-panels::page>
<div class="arah">
    @foreach ($companies as $c)
        <div class="arah-card" style="margin-bottom:1rem">
            @unless ($single)<h3>{{ $c->code }} — {{ $c->name }}</h3>@else<h3>{{ $c->name }}</h3>@endunless
            <div class="arah-muted" style="margin-bottom:.8rem">{{ $c->address }}, {{ $c->city }} · {{ $c->room_count }} kamar</div>
            <div class="arah-grid arah-grid-3">
                @foreach ($c->periods as $p)
                    <div class="arah-card" style="{{ $p->id === $currentPeriod ? 'border:2px solid var(--k-taum)' : '' }}">
                        <h3>{{ $p->name }} <span class="arah-badge {{ $p->status === 'berjalan' ? 'arah-hijau' : ($p->status === 'perencanaan' ? 'arah-kuning' : 'arah-abu') }}">{{ $p->status }}</span></h3>
                        <div class="arah-muted">{{ $p->start_date->translatedFormat('d M Y') }} – {{ $p->end_date->translatedFormat('d M Y') }}</div>
                        <div style="font-size:.8rem; margin:.5rem 0">{{ $p->notes }}</div>
                        @if ($p->id === $currentPeriod)
                            <span class="arah-badge arah-biru">Sedang aktif</span>
                        @else
                            <button type="button" class="arah-btn arah-btn-primary" wire:click="pilih({{ $p->id }})">Gunakan perioda ini</button>
                        @endif
                    </div>
                @endforeach
            </div>
        </div>
    @endforeach
</div>
</x-filament-panels::page>
