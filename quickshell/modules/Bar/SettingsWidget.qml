import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
    id: root

    implicitWidth: layout.implicitWidth + 8
    implicitHeight: 20
    color: Theme.accent3
    radius: 4

    RowLayout {
        id: layout

        spacing: 8
        anchors.centerIn: parent

        BrightnessWidget {
        }

        AudioSinkWidget {
        }

        AudioSourceWidget {
        }

    }

}
