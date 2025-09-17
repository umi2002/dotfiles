pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property list<bool> occupiedWorkspaces: Array.from({
        length: 10
    }, () => {
        return false;
    })
    property var windows: []
    property var workspaces: []
    property var mainWindows: ({})
    property var windowIcons: ({})

    signal mainWindowsUpdated
    signal windowIconsUpdated

    function updateWorkspaces() {
        let workspaces = Hyprland.workspaces?.values;

        if (!workspaces) {
            return;
        }

        workspaces.forEach(workspace => {
            occupiedWorkspaces[workspace.id - 1] = workspace.toplevels?.values.length !== 0;
        });
    }

    function getIcon(windowClass) {
        const entry = DesktopEntries.heuristicLookup(windowClass);
        return entry ? Quickshell.iconPath(entry.icon) : "";
    }

    Process {
        id: getWorkspaces
        command: ["hyprctl", "workspaces", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                let workspaces = JSON.parse(text);
                root.workspaces = workspaces;
                Hyprland.workspaces.values.forEach(workspace => {
                    occupiedWorkspaces[workspace.id - 1] = workspace.toplevels?.values.length !== 0;
                });
            }
        }
    }

    Process {
        id: updateClients
        command: ["hyprctl", "clients", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                let windows = JSON.parse(text);
                root.windows = windows;
                root.workspaces.forEach(workspace => {
                    let id = workspace.id;
                    root.mainWindows[id] = windows.find(window => {
                        return window.workspace.id === id;
                    }).class;
                });

                root.mainWindowsUpdated();
            }
        }
    }

    Component.onCompleted: {
        getWorkspaces.running = true;
    }

    Connections {
        target: Hyprland

        function onRawEvent() {
            getWorkspaces.running = true;
        }
    }

    onWorkspacesChanged: {
        updateClients.running = true;
    }

    onMainWindowsUpdated: {
        for (let window in mainWindows) {
            windowIcons[window] = getIcon(mainWindows[window]);
        }

        windowIconsUpdated();
    }
}
