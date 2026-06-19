import QtQuick
import QtQuick.Layouts
import Quickshell
import qs
import qs.utils

Scope {
    id: root

    property string icon: ""
    property real value: 0
    property color bg: Theme.bg3
    property color fg: Theme.fg0
    property color barBg: Theme.bg2
    property color barFg: Theme.fg0
    property int duration: 2000
    property bool visible: false

    signal requestHide()

    function show() {
        root.visible = true;
        hideTimer.restart();
    }

    Timer {
        id: hideTimer

        interval: root.duration
        onTriggered: {
            root.visible = false;
            root.requestHide();
        }
    }

    LazyLoader {
        active: root.visible

        Variants {
            model: Quickshell.screens

            PanelWindow {
                required property var modelData

                screen: modelData
                anchors.bottom: true
                anchors.left: true
                margins.bottom: 16
                margins.left: 16
                exclusiveZone: 0
                implicitWidth: 256
                implicitHeight: 32
                color: "transparent"

                Rectangle {
                    anchors.fill: parent
                    radius: 4
                    color: root.bg

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 1
                        radius: parent.radius
                        color: Theme.bg0

                        RowLayout {
                            anchors.fill: parent
                            anchors.centerIn: parent
                            anchors.leftMargin: 12
                            anchors.rightMargin: 12
                            spacing: 12

                            Text {
                                text: root.icon
                                color: root.fg
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                implicitHeight: 8
                                radius: 4
                                color: root.barBg

                                Rectangle {
                                    width: parent.width * Math.max(0, Math.min(1, root.value))
                                    height: parent.height
                                    radius: parent.radius
                                    color: root.barFg
                                }

                            }

                            Text {
                                text: Format.formatPercentage(root.value)
                                color: root.fg
                                font.pixelSize: 12
                            }

                        }

                    }

                }

                mask: Region {
                }

            }

        }

    }

}
