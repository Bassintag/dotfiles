import QtQuick
import qs

Rectangle {
    property string icon

    implicitWidth: 16
    implicitHeight: 16
    radius: 4
    color: "transparent"

    Text {
        anchors.centerIn: parent
        text: icon
        font.pixelSize: 12
    }

}
