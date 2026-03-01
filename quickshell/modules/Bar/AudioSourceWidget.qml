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
    if (Audio.source.audio.muted) {
      return ""
    } else {
      return ""
    }
  }
}
