import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs
import qs.services
import qs.utils
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import QtQuick.Effects

Rectangle {
  property string icon

  implicitWidth: 16
  implicitHeight: 16
  radius: 4
  color: "transparent"
  
  Text {
    anchors.centerIn: parent
    color: Theme.bg0

    text: icon
  }
}
