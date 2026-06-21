import QtQuick
import Quickshell
import Quickshell.Networking
import qs
pragma Singleton

Singleton {
    readonly property NetworkDevice device: {
        return Networking.devices.values.find((d) => {
            return d.connected;
        }) || null;
    }
    readonly property Network network: {
        if (device == null)
            return null;

        return device.networks.values[0] || null;
    }
    readonly property int state: {
        if (network == null)
            return ConnectionState.Disconnected;

        return network.state;
    }
    readonly property string label: {
        switch (state) {
        case ConnectionState.Connecting:
            return "Connecting";
        case ConnectionState.Disconnecting:
            return "Disconnecting";
        case ConnectionState.Connected:
            return network.name;
        case ConnectionState.Disconnected:
            return "Disconnected";
        }
    }
    readonly property string color: {
        switch (state) {
        case ConnectionState.Connecting:
        case ConnectionState.Disconnecting:
            return Theme.yellow;
        case ConnectionState.Connected:
            return Theme.accent1;
        case ConnectionState.Disconnected:
            return Theme.red;
        }
    }
    readonly property string icon: {
        if (device != null && device.type === DeviceType.Wired)
            return "󰈁";

        let icons;
        switch (state) {
        case ConnectionState.Disconnected:
            return "󰤭";
        case ConnectionState.Connecting:
        case ConnectionState.Disconnecting:
            icons = ["󰤫", "󰤠", "󰤣", "󰤦", "󰤩"];
            break;
        case ConnectionState.Connected:
            icons = ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"];
            break;
        }
        return icons[Math.floor(network.signalStrength * icons.length)];
    }
}
