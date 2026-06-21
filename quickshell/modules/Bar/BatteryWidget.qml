import QtQuick
import QtQuick.Layouts
import qs
import qs.services
import qs.utils

Rectangle {
    id: root

    implicitWidth: layout.implicitWidth + 8
    implicitHeight: 20
    color: Battery.danger ? Theme.red : Battery.warning ? Theme.yellow : Theme.accent1
    radius: 4
    visible: Battery.device.isLaptopBattery

    RowLayout {
        id: layout

        spacing: 2
        anchors.centerIn: parent

        IconWidget {
            icon: Battery.icon
        }

        Text {
            text: Format.formatPercentage(Battery.percentage)
            font.pixelSize: 12
        }

    }

}
