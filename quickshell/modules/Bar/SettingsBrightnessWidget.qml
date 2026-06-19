import QtQuick
import QtQuick.Layouts
import qs.services
import qs.utils

RowLayout {
    id: layout

    spacing: 2
    visible: Brightness.enabled

    IconWidget {
        icon: Brightness.icon
    }

    Text {
        text: Format.formatPercentage(Brightness.value)
        font.pixelSize: 12
    }

}
