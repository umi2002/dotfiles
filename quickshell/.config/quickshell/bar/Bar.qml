import Quickshell
import QtQuick
import Quickshell.Io

import "components"

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
                    bar.screen = Quickshell.screens.filter(screen => screen.name == match[1])[0];
                }
            }
        }
    }

    // The default screen a panel will be created on under hyprland is the currently
    // focused one. We use this since we don't get a focusedmon event on connect.

    PanelWindow {
        id: bar
        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: 30

        Clock {
            anchors.centerIn: parent
        }
    }
}
