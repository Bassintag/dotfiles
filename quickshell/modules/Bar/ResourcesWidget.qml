import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
  id: root

  implicitWidth: childrenRect.width + 8
  implicitHeight: 20

  color: Theme.accent0
  radius: 4

  RowLayout {
    id: row
    spacing: 8

    anchors.centerIn: parent

    ResourcesMemoryWidget {}
    ResourcesCpuWidget {}
  }
}