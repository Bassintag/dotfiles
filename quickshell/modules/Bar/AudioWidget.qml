import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
    id: root

    implicitWidth: layout.implicitWidth + 8
    implicitHeight: 20
    color: Theme.accent2
    radius: 4

    RowLayout {
        id: layout

        spacing: 4
        anchors.centerIn: parent

        AudioSinkWidget {
        }

        AudioSourceWidget {
        }

    }

}
