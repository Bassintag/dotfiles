import QtQuick
import qs
import qs.services

Text {
  id: clock
  anchors.centerIn: parent
  color: Theme.fg0
  text: Time.time
  font { pixelSize: 12; bold: true }
}