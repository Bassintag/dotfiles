import QtQuick
import Quickshell
import Quickshell.Services.Notifications
pragma Singleton

Scope {
    function getAppIcon(name: string, fallback: string) : string {
        const entry = DesktopEntries.heuristicLookup(name);
        if (entry == null)
            return null;

        if (fallback !== "undefined")
            return Quickshell.iconPath(entry, fallback);

        return Quickshell.iconPath(entry.icon);
    }

}
