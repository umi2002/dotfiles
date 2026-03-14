pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property int nWorkspaces: 10

    property list<bool> occupiedWorkspaces: new Array(nWorkspaces).fill(false)
    property var workspaceIcons: ({})
    property string keyboardLanguage: ""

    signal workspaceIconsUpdated

    property var windowWorkspaces: ({})
    property var windowClasses: ({})
    property var workspaceLastWindows: ({})

    function resolveIcon(windowClass) {
        if (!windowClass)
            return "";
        const entry = DesktopEntries.byId(windowClass);
        if (!entry?.icon)
            return "";
        return Quickshell.iconPath(entry.icon);
    }

    function updateOccupiedWorkspaces() {
        const occupied = new Array(nWorkspaces).fill(false);
        Object.values(windowWorkspaces).forEach(wsId => {
            if (wsId >= 1 && wsId <= nWorkspaces)
                occupied[wsId - 1] = true;
        });
        for (let i = 0; i < nWorkspaces; i++)
            occupiedWorkspaces[i] = occupied[i];
    }

    function updateWorkspaceIcon(workspaceId) {
        const lastAddr = workspaceLastWindows[workspaceId];
        const addr = (lastAddr && windowWorkspaces[lastAddr] === workspaceId) ? lastAddr : Object.entries(windowWorkspaces).find(([, wsId]) => wsId === workspaceId)[0] ?? null;

        const icon = addr ? resolveIcon(windowClasses[addr] ?? "") : "";
        if (icon)
            workspaceIcons[workspaceId] = icon;
        else
            delete workspaceIcons[workspaceId];
        workspaceIconsUpdated();
    }

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            switch (event.name) {
            case "openwindow":
                {
                    const args = event.parse(4);
                    const addr = "0x" + args[0];
                    const workspaceId = parseInt(args[1]);
                    root.windowWorkspaces[addr] = workspaceId;
                    root.windowClasses[addr] = args[2];
                    root.workspaceLastWindows[workspaceId] = addr;
                    root.updateOccupiedWorkspaces();
                    root.updateWorkspaceIcon(workspaceId);
                    break;
                }
            case "closewindow":
                {
                    const args = event.parse(1);
                    const addr = "0x" + args[0];
                    const workspaceId = root.windowWorkspaces[addr];
                    delete root.windowWorkspaces[addr];
                    delete root.windowClasses[addr];
                    if (root.workspaceLastWindows[workspaceId] === addr)
                        delete root.workspaceLastWindows[workspaceId];
                    root.updateOccupiedWorkspaces();
                    if (workspaceId)
                        root.updateWorkspaceIcon(workspaceId);
                    break;
                }
            case "movewindow":
                {
                    const args = event.parse(2);
                    const addr = "0x" + args[0];
                    const newWorkspaceId = parseInt(args[1]);
                    const oldWorkspaceId = root.windowWorkspaces[addr];
                    root.windowWorkspaces[addr] = newWorkspaceId;
                    if (root.workspaceLastWindows[oldWorkspaceId] === addr)
                        delete root.workspaceLastWindows[oldWorkspaceId];
                    root.workspaceLastWindows[newWorkspaceId] = addr;
                    root.updateOccupiedWorkspaces();
                    if (oldWorkspaceId)
                        root.updateWorkspaceIcon(oldWorkspaceId);
                    root.updateWorkspaceIcon(newWorkspaceId);
                    break;
                }
            case "activewindowv2":
                {
                    const args = event.parse(1);
                    const addr = "0x" + args[0];
                    const workspaceId = root.windowWorkspaces[addr];
                    if (workspaceId) {
                        root.workspaceLastWindows[workspaceId] = addr;
                        root.updateWorkspaceIcon(workspaceId);
                    }
                    break;
                }
            case "activelayout":
                devicesProcess.running = true;
                break;
            }
        }
    }

    Process {
        id: clientsProcess
        command: ["hyprctl", "clients", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                JSON.parse(this.text).forEach(client => {
                    const addr = client.address;
                    const wsId = client.workspace?.id;
                    const cls = client.class;
                    if (addr && wsId && cls) {
                        root.windowWorkspaces[addr] = wsId;
                        root.windowClasses[addr] = cls;
                    }
                });
                root.updateOccupiedWorkspaces();
                const uniqueWorkspaces = new Set(Object.values(root.windowWorkspaces));
                uniqueWorkspaces.forEach(wsId => root.updateWorkspaceIcon(wsId));
            }
        }
    }

    Process {
        id: devicesProcess
        command: ["hyprctl", "devices", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                const devices = JSON.parse(this.text);
                const mainKeyboard = devices.keyboards?.find(kb => kb.main);
                if (mainKeyboard)
                    root.keyboardLanguage = mainKeyboard.active_keymap.substring(0, 2);
            }
        }
    }

    Component.onCompleted: {
        clientsProcess.running = true;
        devicesProcess.running = true;
    }
}
