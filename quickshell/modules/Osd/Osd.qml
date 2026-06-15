import QtQuick
import QtQuick.Layouts
import Quickshell
import qs
import qs.services
import qs.utils

Scope {
    id: root

    property bool show: false

    Connections {
        function onVolumeChanged() {
            root.show = true;
            hideTimer.restart();
        }

        target: Audio.sink.audio
    }

    Timer {
        id: hideTimer

        interval: 2000
        onTriggered: root.show = false
    }

    LazyLoader {
        active: show

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
                    color: Theme.bg3

                    Rectangle {
                        radius: parent.radius
                        color: Theme.bg0

                        anchors {
                            fill: parent
                            margins: 1
                        }

                        RowLayout {
                            spacing: 12

                            anchors {
                                fill: parent
                                leftMargin: 12
                                rightMargin: 12
                            }

                            Text {
                                text: Audio.getSinkIcon(Audio.sink)
                                color: Theme.fg0
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                implicitHeight: 8
                                radius: 4
                                color: Theme.bg2

                                Rectangle {
                                    implicitWidth: parent.width * (Audio.sink.audio.volume ?? 0)
                                    radius: parent.radius
                                    color: Theme.fg0

                                    anchors {
                                        left: parent.left
                                        top: parent.top
                                        bottom: parent.bottom
                                    }

                                }

                            }

                            Text {
                                text: {
                                    Format.formatPercentage(Audio.sink.audio.volume);
                                }
                                color: Theme.fg0
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
