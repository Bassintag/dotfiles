import QtQuick
import QtQuick.Layouts
import qs
import qs.services
import qs.utils

Rectangle {
    id: root

    implicitWidth: layout.implicitWidth + 8
    implicitHeight: 20
    color: Theme.accent1
    radius: 4

    RowLayout {
        id: layout

        spacing: 2
        anchors.centerIn: parent

        IconWidget {
            icon: Network.icon
        }

        Text {
            text: Network.label
            font.pixelSize: 12
        }

    }

}
