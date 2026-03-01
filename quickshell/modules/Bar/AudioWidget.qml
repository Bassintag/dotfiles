import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs
import qs.services
import qs.utils
import Quickshell.Services.Mpris
import Quickshell.Widgets
import QtQuick.Effects
import Quickshell.Services.Pipewire

Rectangle {
  id: root

  implicitWidth: childrenRect.width + 8
  implicitHeight: 20

  color: Theme.accent2
  radius: 4

  RowLayout {
    id: row
    spacing: 4

    anchors.centerIn: parent

    AudioSinkWidget {}
    AudioSourceWidget {}
  }
}