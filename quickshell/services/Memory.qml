pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick


Singleton {
  property real used
  property real total
  property real usage

  Process {
    id: memoryProc
    command: ["sh", "-c", "free | grep Mem"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split(/\s+/)
        total = parseInt(parts[1]) || 1
        used = parseInt(parts[2]) || 0
        usage = used / total
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: {
      memoryProc.running = true
    }
  }
}