import QtQuick
import Quickshell
pragma Singleton

Scope {
    function formatPercentage(value) : string {
        return (value * 100).toFixed(0) + " %";
    }

}
