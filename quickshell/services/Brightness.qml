import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    property bool enabled: false
    property string icon: ""
    property real value: 0

    Process {
        command: ["sh", "-c", "brightnessctl -lm"]
        running: true

        stdout: SplitParser {
            onRead: (data) => {
                const parts = data.split(",");
                if (parts[1] === "backlight")
                    enabled = true;

            }
        }

    }

    Process {
        command: ["sh", "-c", "udevadm monitor --subsystem-match=backlight --udev"]
        running: true

        stdout: SplitParser {
            onRead: updateBrightness.running = true
        }

    }

    Process {
        id: updateBrightness

        command: ["sh", "-c", "brightnessctl -m"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                value = parseInt(this.text.split(",")[3].replace("%", "")) / 100;
                if (value > 1 / 2)
                    icon = "󰃠";
                else if (value >= 0.01)
                    icon = "󰃟";
                else
                    icon = "󰃞";
            }
        }

    }

}
