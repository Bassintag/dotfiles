pragma Singleton

import QtQuick
import Quickshell.Services.Mpris

QtObject {
  id: root

  readonly property MprisPlayer active: Mpris.players.values[0]

}
