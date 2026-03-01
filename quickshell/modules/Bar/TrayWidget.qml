import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick

MouseArea {
  required property SystemTrayItem modelData

  id: root

  acceptedButtons: Qt.LeftButton | Qt.RightButton

  implicitWidth: 16
  implicitHeight: 16
  onClicked: event => {
    if (event.button === Qt.LeftButton) {
        modelData.activate();
    } else {
        modelData.display(window, 4, window.implicitHeight);
    }
  }

  IconImage {
    anchors.fill: parent
    asynchronous: true
    source: root.modelData.icon
  }
}