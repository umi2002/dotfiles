import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import "components"
import "../Style.js" as Style

ShellRoot {
    Socket {
        // Create and connect a Socket to the hyprland event socket.
        // https://wiki.hyprland.org/IPC/
        path: `${Quickshell.env("XDG_RUNTIME_DIR")}/hypr/${Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE")}/.socket2.sock`
        connected: true

        parser: SplitParser {
            // Regex that will return the newly focused monitor when it changes.
            property var regex: new RegExp("focusedmon>>(.+),.*")

            // Sent for every line read from the socket
            onRead: msg => {
                const match = regex.exec(msg);

                if (match != null) {
                    // Filter out the right screen from the list and update the panel.
                    // match[1] will always be the monitor name captured by the regex.
                    topBar.screen = Quickshell.screens.filter(screen => screen.name == match[1])[0];
                }
            }
        }
    }

    // The default screen a panel will be created on under hyprland is the currently
    // focused one. We use this since we don't get a focusedmon event on connect.

    PanelWindow {
        id: topBar
        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: 50

        color: Style.palette.background1

        RowLayout {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            spacing: 20

            Image {
                source: "../assets/arch_linux_icon.svg"

                sourceSize.width: 30
                sourceSize.height: 30
                Layout.alignment: Qt.AlignVCenter
            }

            Workspaces {
                Layout.preferredWidth: childrenRect.width + 40
                Layout.preferredHeight: childrenRect.height + 5
                Layout.alignment: Qt.AlignVCenter
                radius: Math.min(width, height) / 2

                color: Style.palette.background2
            }
        }

        Clock {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10

            color: Style.palette.color2
            font.family: Style.font.family
            font.pointSize: Style.font.size1
        }
    }
}
