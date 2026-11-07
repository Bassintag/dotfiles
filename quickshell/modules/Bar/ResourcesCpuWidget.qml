import QtQuick
import QtQuick.Layouts
import qs
import qs.services
import qs.utils

RowLayout {
    spacing: 2

    IconWidget {
        icon: ""
    }

    Text {
        text: Format.formatPercentage(Cpu.usage)
        font.family: Theme.fontFamily
        font.pixelSize: 12
    }

}
