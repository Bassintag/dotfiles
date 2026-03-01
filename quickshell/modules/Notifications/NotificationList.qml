import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Services.Notifications

Scope {
  id: root

  NotificationServer {
    id: notificationServer
    actionsSupported: true
    imageSupported: true
    onNotification: (n) => {
      n.tracked = true
    }
  }

  PanelWindow {
    color: "transparent"


    anchors {
      top: true
      right: true
    }


    implicitWidth: content.implicitWidth + 16
    implicitHeight: content.implicitHeight + 16


    ColumnLayout {
      id: content
      spacing: 8
    
      anchors {
        top: parent.top
        right: parent.right
        topMargin: 16
        rightMargin: 16
      }

      Repeater {
        model: notificationServer.trackedNotifications
        NotificationCard { model: modelData }
      }
    }
  }
}
