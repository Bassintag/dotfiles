import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
    id: root

    color: Theme.accent0
    radius: 4
    implicitWidth: layout.implicitWidth + 8
    implicitHeight: layout.implicitHeight + 4

    RowLayout {
        id: layout

        anchors.centerIn: parent
        spacing: 8

        ResourcesMemoryWidget {
        }

        ResourcesCpuWidget {
        }

    }

}
