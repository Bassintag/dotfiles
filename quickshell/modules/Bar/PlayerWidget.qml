import QtQuick
import QtQuick.Layouts
import qs
import qs.services
import Quickshell.Services.Mpris

Rectangle {
  id: root

  readonly property MprisPlayer player: Player.active
  readonly property var track: {
    if (player == null) return null
    let parts = []
    if (player.trackArtist) {
      parts.push(player.trackArtist)
    }
    if (player.trackAlbum) {
      parts.push(player.trackAlbum)
    }
    if (player.trackTitle) {
      parts.push(player.trackTitle)
    }
    if (parts.length === 0) return null
    return {title: parts.join(" - ")}
  }

  visible: player != null

  implicitWidth: childrenRect.width
  implicitHeight: 20

  color: Theme.fg2
  radius: 4

  RowLayout {
    id: row
    spacing: 0

    height: parent.height

    MouseArea {
      implicitWidth: childrenRect.width
      implicitHeight: childrenRect.height

      Rectangle {
        implicitHeight: root.height
        implicitWidth: root.height

        color: Theme.fg0
        radius: root.radius

        Text {
          anchors.centerIn: parent
          color: Theme.bg2
          text: player?.isPlaying ? "" : ""
          font.pixelSize: 12
        }
      }

      onClicked: {
        if (!player) return
        player.isPlaying ? player.pause() : player.play()
      }
    }

    Flickable {
      id: marquee
      contentWidth: title.paintedWidth
      interactive: false
      boundsBehavior: Flickable.StopAtBounds
      implicitHeight: title.paintedHeight
      implicitWidth: Math.min(title.paintedWidth + padding * 2, 256)
      leftMargin: padding
      rightMargin: padding

      clip: true

      property bool overflowing: title.paintedWidth > width
      property int padding: 4

      Text {
        id: title
        text: track.title
        color: Theme.bg2
        font.pixelSize: 12
      }

      SequentialAnimation on contentX {
        running: marquee.overflowing
        loops: Animation.Infinite

        PauseAnimation { duration: 2000 }
        NumberAnimation {
          from: -marquee.padding
          to: marquee.contentWidth - marquee.width + marquee.padding
          duration: (marquee.contentWidth - marquee.width + marquee.padding * 2) / 20 * 1000
          easing.type: Easing.Linear
        }
        PauseAnimation { duration: 2000 }
        NumberAnimation {
          from: marquee.contentWidth - marquee.width + marquee.padding
          to: -marquee.padding
          duration: (marquee.contentWidth - marquee.width + marquee.padding * 2) / 80 * 1000
          easing.type: Easing.Linear
        }
      }
    }
  }
}
