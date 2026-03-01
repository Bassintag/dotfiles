import Quickshell
import QtQuick
import QtQuick.Layouts
import qs
import qs.services
import qs.utils

Scope {
  id: root
  property bool show: false

  Connections {
		target: Audio.sink.audio

		function onVolumeChanged() {
			root.show = true;
      hideTimer.restart()
		}
	}

  Timer {
		id: hideTimer
		interval: 2000
		onTriggered: root.show = false
	}

  LazyLoader {
    active: show

    Variants {
      model: Quickshell.screens

      PanelWindow {
        required property var modelData

        screen: modelData
  
        anchors.bottom: true
        anchors.left: true
        margins.bottom: 16
        margins.left: 16
        exclusiveZone: 0

        implicitWidth: 256
        implicitHeight: 32
        color: "transparent"

        mask: Region {}

        Rectangle {
          anchors.fill: parent
          radius: 4
          color: Theme.bg3

          Rectangle {
            anchors {
              fill: parent
              margins: 1
            }
            radius: parent.radius
            color: Theme.bg0

            RowLayout {
              anchors {
                fill: parent
                leftMargin: 12
                rightMargin: 12
              }
              spacing: 12

              Text {
                text: Audio.getSinkIcon(Audio.sink)
                color: Theme.fg0
              }

              Rectangle {
                Layout.fillWidth: true

                implicitHeight: 8
                radius: 4
                color: Theme.bg2

                Rectangle {
                  anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                  }

                  implicitWidth: parent.width * (Audio.sink?.audio.volume ?? 0)
                  radius: parent.radius
                  color: Theme.fg0
                }
              }

              Text {
                text: {
                  Format.formatPercentage(Audio.sink.audio.volume)
                }
                color: Theme.fg0
                font.pixelSize: 12
              }
            }
          }
        }
      }
    }
  }
}