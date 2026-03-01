pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Scope {
  function getAppIcon(name: string, fallback: string): string {
    const icon = DesktopEntries.heuristicLookup(name)?.icon;
    if (fallback !== "undefined") return Quickshell.iconPath(icon, fallback);
    return Quickshell.iconPath(icon);
  }
}