import QtQml
import Quickshell
import Quickshell.Hyprland
pragma Singleton

Singleton {
    property ShellScreen active: getActive()

    function getActive() {
        for (const screen of Quickshell.screens) {
            const monitor = Hyprland.monitorFor(screen);
            if (monitor.activeWorkspace == null)
                continue;

            if (!monitor.activeWorkspace.focused)
                continue;

            return screen;
        }
        return null;
    }

    Connections {
        function onRawEvent(event) {
            if (event.name === "focusedmon")
                active = getActive();

        }

        target: Hyprland
    }

}
