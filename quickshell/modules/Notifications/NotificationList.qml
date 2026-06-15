import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications

Scope {
    id: root

    NotificationServer {
        id: notificationServer

        actionsSupported: true
        imageSupported: true
        onNotification: (n) => {
            n.tracked = true;
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            color: "transparent"
            implicitWidth: content.implicitWidth + 16
            implicitHeight: content.implicitHeight + 16

            anchors {
                top: true
                right: true
            }

            ColumnLayout {
                id: content

                spacing: 8

                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: 16
                    rightMargin: 16
                }

                Repeater {
                    model: notificationServer.trackedNotifications

                    NotificationCard {
                        model: modelData
                    }

                }

            }

        }

    }

}
