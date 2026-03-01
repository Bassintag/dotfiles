pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    property real usage: 0

    property int prevTotal: 0
    property int prevIdle: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "cat /proc/stat | head -n 1"]

        stdout: SplitParser {
            onRead: data => {
                if (!data) return

                let parts = data.trim().split(/\s+/)

                let user = parseInt(parts[1]) || 0
                let nice = parseInt(parts[2]) || 0
                let system = parseInt(parts[3]) || 0
                let idle = parseInt(parts[4]) || 0
                let iowait = parseInt(parts[5]) || 0
                let irq = parseInt(parts[6]) || 0
                let softirq = parseInt(parts[7]) || 0
                let steal = parseInt(parts[8]) || 0

                let total = user + nice + system + idle + iowait + irq + softirq + steal
                let idleTotal = idle + iowait

                if (prevTotal !== 0) {
                    let deltaTotal = total - prevTotal
                    let deltaIdle = idleTotal - prevIdle

                    if (deltaTotal > 0) {
                        usage = (deltaTotal - deltaIdle) / deltaTotal
                    }
                }

                prevTotal = total
                prevIdle = idleTotal
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: cpuProc.running = true
    }
}