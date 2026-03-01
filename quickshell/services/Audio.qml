pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    PwObjectTracker {
        objects: [sink, source]
    }

    function getSinkIcon(sink) {
        if (sink.audio.muted) {
            return ""
        }
        if (sink.audio.volume < 0.01) {
            return ""
        }
        const icons = ["", ""]
        const i = Math.floor(sink.audio.volume * icons.length)
        return icons[i]
    }
}