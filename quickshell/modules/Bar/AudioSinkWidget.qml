import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs
import qs.services
import qs.utils
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import QtQuick.Effects

IconWidget {
  icon: {
    if (Audio.sink.audio.muted) {
      return ""
    }
    if (Audio.sink.audio.volume < 0.01) {
      return ""
    }
    const icons = ["", ""]
    const i = Math.floor(Audio.sink.audio.volume * icons.length)
    return icons[i]
  }
}
