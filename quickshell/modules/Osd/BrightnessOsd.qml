import QtQuick
import Quickshell
import qs.services
import qs.utils

Osd {
    id: root

    icon: Brightness.icon
    value: Brightness.value

    Connections {
        function onValueChanged() {
            root.show();
        }

        target: Brightness
    }

}
