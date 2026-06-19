import QtQuick
import Quickshell
import Quickshell.Networking
pragma Singleton

Singleton {
    readonly property NetworkDevice device: {
        return Networking.devices.values.find((d) => {
            return d.connected;
        });
    }
    readonly property Network network: {
        if (device == null)
            return null;

        return device.networks.values.find((n) => {
            return n.state === ConnectionState.Connected;
        });
    }
    readonly property string label: {
        if (network == null)
            return null;

        return network.name;
    }
    readonly property string icon: {
        if (device == null || network == null)
            return "󰤭";

        if (device.type === DeviceType.Wired)
            return "󰈁";

        const icons = ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"];
        return icons[Math.floor(network.signalStrength * icons.length)];
    }
}
