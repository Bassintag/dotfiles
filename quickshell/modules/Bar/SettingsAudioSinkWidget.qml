import QtQuick
import QtQuick.Layouts
import qs.services
import qs.utils

RowLayout {
    id: layout

    spacing: 2

    IconWidget {
        icon: Audio.getSinkIcon(Audio.sink)
    }

    Text {
        text: Format.formatPercentage(Audio.sink.audio.volume)
        font.pixelSize: 12
    }

}
