import QtQuick
import Quickshell.Services.Mpris
pragma Singleton

QtObject {
    id: root

    readonly property MprisPlayer active: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
}
