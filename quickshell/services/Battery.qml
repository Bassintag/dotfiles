import Quickshell
import Quickshell.Services.UPower
pragma Singleton

Singleton {
    readonly property UPowerDevice device: UPower.displayDevice
    readonly property real percentage: {
        device.percentage;
    }
    readonly property bool charging: {
        device.state === UPowerDeviceState.Charging;
    }
    readonly property string icon: {
        if (charging)
            return "󱐋";

        if (percentage > 0.8)
            return "";

        if (percentage > 0.6)
            return "";

        if (percentage > 0.4)
            return "";

        if (percentage > 0.2)
            return "";

        return "";
    }
    readonly property bool warning: {
        return percentage < 0.2;
    }
    readonly property bool danger: {
        return percentage < 0.1;
    }
}
