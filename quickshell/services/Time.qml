pragma Singleton

import Quickshell

Singleton {
  readonly property string time: {
    Qt.formatDateTime(clock.date, "d MMM. HH:mm")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}