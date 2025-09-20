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
    property var workspaceLastWindows: ({})
    property var windows: ({})
    property var workspaceIcons: ({})
    property string keyboardLanguage: ""

    signal workspacesUpdated
    signal windowsUpdated
    signal workspaceIconsUpdated

    function updateWorkspace(workspaceId, lastwindow) {
        root.workspaceLastWindows[workspaceId] = lastwindow;
        workspacesUpdated();
    }

    function updateOccupiedWorkspaces() {
        let workspaces = Hyprland.workspaces?.values;

        if (!workspaces) {
            return;
        }

        workspaces.forEach(workspace => {
            occupiedWorkspaces[workspace.id - 1] = workspace.toplevels?.values.length !== 0;
        });
    }

    function addWindow(windowAddress, workspaceId, windowClass) {
        root.windows[windowAddress] = {
            workspaceId: workspaceId,
            class: windowClass
        };
    }

    function deleteWindow(windowAddress) {
        const workspaceId = root.windows[windowAddress]?.workspaceId;
        if (!workspaceId) {
            return;
        }

        delete root.workspaceIcons[workspaceId];
        delete root.windows[windowAddress];

        refreshWorkspaceProcess.targetWorkspaceId = workspaceId;
        refreshWorkspaceProcess.running = true;
    }

    function updateWorkspaceIcons(workspaceId, windowClass) {
        workspaceIcons[workspaceId] = getIcon(windowClass);

        workspaceIconsUpdated();
    }

    function getIcon(windowClass) {
        const entry = DesktopEntries.byId(windowClass);
        return entry?.icon ? Quickshell.iconPath(entry.icon) : "";
    }

    function handleWorkspacesData(workspaces) {
        workspaces.forEach(workspace => {
            updateWorkspace(workspace.id, workspace.lastwindow);
        });
        root.updateOccupiedWorkspaces();
        root.workspacesUpdated();
    }

    function handleClientsData(clients) {
        root.windows = {};
        clients.forEach(client => {
            root.addWindow(client.address, client.workspace.id, client.class);
        });
        root.windowsUpdated();
    }

    function handleDevicesData(devices) {
        let keyboards = devices.keyboards;
        if (keyboards && keyboards.length > 0) {
            let language = keyboards[keyboards.length - 1].active_keymap;
            root.keyboardLanguage = language.substring(0, 2);
        }
    }

    Process {
        id: workspacesProcess
        command: ["hyprctl", "workspaces", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                const data = JSON.parse(text);
                root.handleWorkspacesData(data);
            }
        }
    }

    Process {
        id: refreshWorkspaceProcess
        property int targetWorkspaceId: -1
        command: ["hyprctl", "workspaces", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                const workspaces = JSON.parse(text);
                const workspaceId = refreshWorkspaceProcess.targetWorkspaceId;
                const workspace = workspaces.find(ws => ws.id === workspaceId);

                if (!workspace || workspace.lastwindow === "0x0") {
                    delete root.workspaceLastWindows[workspaceId];
                } else {
                    root.updateWorkspace(workspaceId, workspace.lastwindow);
                }

                root.workspacesUpdated();
            }
        }
    }

    Process {
        id: clientsProcess
        command: ["hyprctl", "clients", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                const data = JSON.parse(text);
                root.handleClientsData(data);
            }
        }
    }

    Process {
        id: devicesProcess
        command: ["hyprctl", "devices", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                const data = JSON.parse(text);
                root.handleDevicesData(data);
            }
        }
    }

    function refreshWorkspaces() {
        workspacesProcess.running = true;
    }

    function refreshClients() {
        clientsProcess.running = true;
    }

    function refreshDevices() {
        devicesProcess.running = true;
    }

    Component.onCompleted: {
        refreshWorkspaces();
        refreshDevices();
    }

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            switch (event.name) {
            case "openwindow":
                {
                    let arguments = event.parse(4);
                    let windowAddress = "0x" + arguments[0];
                    let workspaceId = arguments[1];
                    let windowClass = arguments[2];
                    root.addWindow(windowAddress, workspaceId, windowClass);
                    root.updateWorkspaceIcons(workspaceId, root.windows[windowAddress].class);
                    break;
                }
            case "closewindow":
                {
                    let windowAddress = "0x" + event.parse(1)[0];
                    root.deleteWindow(windowAddress);
                    break;
                }
            case "activelayout":
                {
                    root.refreshDevices();
                    break;
                }
            }
        }
    }

    onWorkspacesUpdated: {
        refreshClients();
    }

    onWindowsUpdated: {
        let workspaceIds = Object.keys(workspaceLastWindows);
        workspaceIds.forEach(workspaceId => {
            let lastWindow = workspaceLastWindows[workspaceId];
            if (windows[lastWindow]) {
                updateWorkspaceIcons(workspaceId, windows[lastWindow].class);
            }
        });
    }
}
