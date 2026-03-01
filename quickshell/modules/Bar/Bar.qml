import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import qs

Scope {
  
  id: root

  property string time

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData

      id: window

      screen: modelData

      color: Theme.bg0

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 32

      // Workspaces
      RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 8


        Repeater {
          model: 9
          WorkspaceWidget {}
        }
      }

      // Time
      TimeWidget {}

      // Widgets
      RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 8
        spacing: 8

        PlayerWidget {}
        Repeater {
          model: SystemTray.items
          TrayWidget {}
        }
        AudioWidget {}
      }
    }
  }
}
