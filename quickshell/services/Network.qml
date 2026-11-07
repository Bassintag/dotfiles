import QtQuick
import Quickshell
import Quickshell.Networking
import qs
pragma Singleton

Singleton {
    readonly property NetworkDevice device: {
        for (const d of Networking.devices.values) {
            if (d.connected)
                return d;

        }
        return null;
    }
    readonly property Network network: {
        if (device == null)
            return null;

        for (const n of device.networks.values) {
            if (n.connected)
                return n;

        }
        return null;
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
        switch (Networking.connectivity) {
        case NetworkConnectivity.None:
            return Theme.red;
        case NetworkConnectivity.Portal:
        case NetworkConnectivity.Limited:
        case NetworkConnectivity.Unknown:
            return Theme.yellow;
        case NetworkConnectivity.Full:
            return Theme.accent1;
        }
    }
    readonly property string icon: {
        if (device != null && device.type === DeviceType.Wired)
            return "󰈁";

        if (Networking.connectivity === NetworkConnectivity.None)
            return "󰤭";

        let icons;
        if (Networking.connectivity === NetworkConnectivity.Full)
            icons = ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"];
        else
            icons = ["󰤫", "󰤠", "󰤣", "󰤦", "󰤩"];
        return icons[Math.floor(network.signalStrength * icons.length)];
    }
}
