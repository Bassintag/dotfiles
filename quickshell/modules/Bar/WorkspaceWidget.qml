import QtQuick
import Quickshell.Hyprland
import qs

Rectangle {
  property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
  property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

  width: 20
  height: 20
  radius: 4

  color: (isActive ? Theme.bg2 : "transparent")

  Text {
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: 4

    text: index + 1
    color: (ws ? Theme.fg1 : Theme.bg3)
    font { pixelSize: 12; bold: true }

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