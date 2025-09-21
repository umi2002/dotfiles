pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property int nWorkspaces: 10
    readonly property var emptyWindow: "0x0"

    property list<bool> occupiedWorkspaces: Array.from({
        length: nWorkspaces
    }, () => {
        return false;
    })
    property var workspaceLastWindows: ({})
    property var windows: ({})
    property var workspaceIcons: ({})
    property string keyboardLanguage: ""

    property var workspaceRefreshQueue: []
    property bool isRefreshingWorkspace: false

    signal workspacesUpdated
    signal windowsUpdated
    signal workspaceIconsUpdated

    function queueWorkspaceRefresh(workspaceIds) {
        workspaceIds.forEach(id => {
            if (!workspaceRefreshQueue.includes(id)) {
                workspaceRefreshQueue.push(id);
            }
        });

        processWorkspaceRefreshQueue();
    }

    function processWorkspaceRefreshQueue() {
        if (isRefreshingWorkspace || workspaceRefreshQueue.length === 0) {
            return;
        }

        isRefreshingWorkspace = true;
        const nextWorkspaceId = workspaceRefreshQueue.shift();

        refreshWorkspaceProcess.targetWorkspaceId = nextWorkspaceId;
        refreshWorkspaceProcess.running = true;
    }

    function updateWorkspace(workspaceId, workspace) {
        if (!workspace || workspace.lastwindow === emptyWindow) {
            delete root.workspaceLastWindows[workspaceId];
        } else {
            root.workspaceLastWindows[workspaceId] = workspace.lastwindow;
        }
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

    function registerWindow(windowAddress, workspaceId, windowClass) {
        if (!windowAddress || !workspaceId || !windowClass) {
            return;
        }

        windows[windowAddress] = {
            workspaceId: workspaceId,
            class: windowClass
        };

        root.updateWorkspaceIcon(workspaceId, windowClass);
    }

    function unregisterWindow(windowAddress) {
        const window = windows[windowAddress];
        if (!window) {
            return;
        }

        const workspaceId = window.workspaceId;
        delete workspaceIcons[workspaceId];
        delete windows[windowAddress];

        refreshWorkspaceProcess.targetWorkspaceId = workspaceId;
        refreshWorkspaceProcess.running = true;
    }

    function updateWorkspaceIcon(workspaceId, windowClass) {
        if (!workspaceId || !windowClass)
            return;

        const iconPath = resolveIcon(windowClass);
        if (!iconPath) {
            return;
        }

        workspaceIcons[workspaceId] = iconPath;
        workspaceIconsUpdated();
    }

    function resolveIcon(windowClass) {
        if (!windowClass)
            return "";

        const entry = DesktopEntries.byId(windowClass);
        if (!entry?.icon) {
            return "";
        }

        return Quickshell.iconPath(entry.icon);
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
            root.registerWindow(client.address, client.workspace.id, client.class);
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

    function refreshAllWorkspaceIcons() {
        Object.keys(workspaceLastWindows).forEach(workspaceId => {
            const lastWindow = workspaceLastWindows[workspaceId];
            const window = windows[lastWindow];
            if (!window) {
                return;
            }
            updateWorkspaceIcon(workspaceId, window.class);
        });
    }

    component HyprctlProcess: Process {
        id: process
        property var onData: null
        property string errorContext: ""

        stdout: StdioCollector {
            onStreamFinished: {
                const data = JSON.parse(text);
                if (process.onData) {
                    process.onData(data);
                }
            }
        }
    }

    HyprctlProcess {
        id: workspacesProcess
        command: ["hyprctl", "workspaces", "-j"]
        onData: root.handleWorkspacesData
    }

    HyprctlProcess {
        id: refreshWorkspaceProcess
        property int targetWorkspaceId: -1
        command: ["hyprctl", "workspaces", "-j"]
        onData: function (workspaces) {
            const workspaceId = refreshWorkspaceProcess.targetWorkspaceId;
            const workspace = workspaces.find(ws => ws.id === workspaceId);

            root.updateWorkspace(workspaceId, workspace);
            root.workspacesUpdated();

            root.isRefreshingWorkspace = false;
            root.processWorkspaceRefreshQueue();
        }
    }

    HyprctlProcess {
        id: clientsProcess
        command: ["hyprctl", "clients", "-j"]
        errorContext: "clients"
        onData: root.handleClientsData
    }

    HyprctlProcess {
        id: devicesProcess
        command: ["hyprctl", "devices", "-j"]
        errorContext: "devices"
        onData: root.handleDevicesData
    }

    readonly property var eventHandlers: ({
            "openwindow": args => {
                const windowAddress = "0x" + args[0];
                const workspaceId = parseInt(args[1]);
                const windowClass = args[2];

                registerWindow(windowAddress, workspaceId, windowClass);
            },
            "closewindow": args => {
                const windowAddress = "0x" + args[0];
                unregisterWindow(windowAddress);
            },
            "movewindow": args => {
                const windowAddress = "0x" + args[0];
                const newWorkspaceId = parseInt(args[1]);

                const window = windows[windowAddress];
                if (window) {
                    const oldWorkspaceId = window.workspaceId;
                    window.workspaceId = newWorkspaceId;

                    delete workspaceIcons[oldWorkspaceId];
                    updateWorkspaceIcon(newWorkspaceId, window.class);

                    queueWorkspaceRefresh([oldWorkspaceId, newWorkspaceId]);
                }
            },
            "activewindowv2": args => {
                const windowAddress = "0x" + args[0];
                const window = windows[windowAddress];

                if (!window) {
                    return;
                }

                const workspaceId = window.workspaceId;

                workspaceLastWindows[workspaceId] = windowAddress;

                updateWorkspaceIcon(workspaceId, window.class);
            },
            "activelayout": () => {
                refresh("devices");
            }
        })

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            const handler = root.eventHandlers[event.name];
            if (!handler)
                return;

            const argCount = {
                "openwindow": 4,
                "closewindow": 1,
                "movewindow": 2,
                "activewindow": 2,
                "activewindowv2": 1,
                "activelayout": 0
            }[event.name] ?? 0;

            const args = argCount > 0 ? event.parse(argCount) : [];
            handler(args);
        }
    }

    function refresh(type = "all") {
        const processes = {
            "workspaces": workspacesProcess,
            "clients": clientsProcess,
            "devices": devicesProcess
        };

        if (type === "all") {
            workspacesProcess.running = true;
            devicesProcess.running = true;
        } else if (processes[type]) {
            processes[type].running = true;
        }
    }

    Component.onCompleted: {
        refresh("all");
    }

    onWorkspacesUpdated: {
        refresh("clients");
    }

    onWindowsUpdated: {
        root.refreshAllWorkspaceIcons();
    }
}
