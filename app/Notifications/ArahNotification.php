<?php

namespace App\Notifications;

use Filament\Actions\Action;
use Filament\Notifications\Notification as FilamentNotification;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

/** Notifikasi umum Arah GPCH: tampil di lonceng Filament (database) dan dikirim via email bila diaktifkan. */
class ArahNotification extends Notification
{
    use Queueable;

    public function __construct(
        public string $title,
        public string $body,
        public ?string $url = null,
        public string $status = 'info',
    ) {}

    public function via(object $notifiable): array
    {
        return env('ARAH_NOTIFY_MAIL', false) ? ['database', 'mail'] : ['database'];
    }

    public function toDatabase(object $notifiable): array
    {
        $n = FilamentNotification::make()->title($this->title)->body($this->body)->status($this->status);
        if ($this->url) {
            $n->actions([Action::make('buka')->label('Buka')->url($this->url)->markAsRead()]);
        }

        return $n->getDatabaseMessage();
    }

    public function toMail(object $notifiable): MailMessage
    {
        $m = (new MailMessage)->subject('[Arah GPCH] '.$this->title)->greeting('Yth. '.$notifiable->name)->line($this->body);
        if ($this->url) {
            $m->action('Buka Arah GPCH', $this->url);
        }

        return $m->salutation('Salam, Arah GPCH');
    }
}
