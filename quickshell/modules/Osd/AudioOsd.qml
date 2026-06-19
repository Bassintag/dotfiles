import QtQuick
import Quickshell
import qs.services
import qs.utils

Osd {
    id: root

    icon: Audio.getSinkIcon(Audio.sink)
    value: Audio.sink.audio.volume ?? 0

    Connections {
        function onVolumeChanged() {
            root.show();
        }

        target: Audio.sink.audio
    }

}
