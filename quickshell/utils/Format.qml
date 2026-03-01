pragma Singleton

import Quickshell
import QtQuick

Scope {
  function formatPercentage(value: number) {
    return (value * 100).toFixed(0) + " %";
  }
}