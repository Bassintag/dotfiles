import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs

Rectangle {
    property var ws: Hyprland.workspaces.values.find((w) => {
        return w.id === index + 1;
    })
    property var monitor: Hyprland.monitorFor(QsWindow.window.screen)
    property bool isActiveHere: ws ? (ws.active && ws.monitor === monitor) : false
    property bool isActiveElsewhere: ws ? (ws.active && ws.monitor !== monitor) : false

    width: 20
    height: 20
    radius: 4
    color: (ws && ws.focused) ? Theme.bg2 : "transparent"

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: index + 1
        color: isActiveElsewhere ? Theme.accent0 : (ws ? Theme.fg1 : Theme.bg3)

        font {

            family: Theme.fontFamily
            pixelSize: 12
            bold: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: Hyprland.dispatch("workspace " + (index + 1))
        }

    }

    Rectangle {
        visible: ws ? ws.urgent : false
        width: 6
        height: 6
        radius: 3
        color: Theme.red
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 2
        anchors.rightMargin: 2
    }

}
