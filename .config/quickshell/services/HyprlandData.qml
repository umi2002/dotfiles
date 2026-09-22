pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

import qs

Singleton {
    id: root

    readonly property int nWorkspaces: Config.nWorkspaces
    readonly property int activeWorkspaceId: Hyprland.focusedWorkspace?.id ?? 0

    readonly property list<bool> occupiedWorkspaces: Array.from({
        length: nWorkspaces
    }, (_, i) => Hyprland.workspaces.values.some(ws => ws.id === i + 1 && ws.toplevels.values.length > 0))
    readonly property var workspaceIcons: {
        const icons = {};
        if (!DesktopEntries.applications.values.length)
            return icons;
        for (const ws of Hyprland.workspaces.values) {
            const windows = ws.toplevels.values;
            const lastAddr = workspaceLastWindows[ws.id];
            const toplevel = windows.find(t => t.address === lastAddr) ?? windows[0];
            const icon = resolveIcon(toplevel?.lastIpcObject?.class ?? "");
            if (icon)
                icons[ws.id] = icon;
        }
        return icons;
    }
    property string keyboardLanguage: ""
    readonly property bool hasFullscreen: Hyprland.focusedWorkspace?.lastIpcObject?.hasfullscreen ?? false

    readonly property var windowClasses: Hyprland.toplevels.values.map(t => t.lastIpcObject?.class ?? "").filter(cls => cls)
    property var workspaceLastWindows: ({})

    function resolveIcon(windowClass) {
        if (!windowClass)
            return "";
        const entry = DesktopEntries.heuristicLookup(windowClass);
        if (!entry?.icon)
            return "";
        return Quickshell.iconPath(entry.icon);
    }

    function updateLastWindow() {
        const toplevel = Hyprland.activeToplevel;
        const workspaceId = toplevel?.workspace?.id;
        if (!workspaceId)
            return;
        workspaceLastWindows = Object.assign({}, workspaceLastWindows, {
            [workspaceId]: toplevel.address
        });
    }

    Connections {
        target: Hyprland

        function onActiveToplevelChanged() {
            root.updateLastWindow();
        }

        function onRawEvent(event) {
            switch (event.name) {
            case "openwindow":
                Hyprland.refreshToplevels();
                break;
            case "activelayout":
                devicesProcess.running = true;
                break;
            case "fullscreen":
                Hyprland.refreshWorkspaces();
                break;
            }
        }
    }

    Connections {
        target: Hyprland.activeToplevel

        function onWorkspaceChanged() {
            root.updateLastWindow();
        }
    }

    function focusWindow(windowClass) {
        const toplevel = Hyprland.toplevels.values.find(t => t.lastIpcObject?.class === windowClass);
        if (toplevel)
            focusWindowByAddress(toplevel.address);
    }

    function focusWindowByAddress(address) {
        Hyprland.dispatch(`hl.dsp.focus({ window = "address:0x${address}" })`);
    }

    function focusWorkspace(workspaceId) {
        Hyprland.dispatch(`hl.dsp.focus({ workspace = ${workspaceId} })`);
    }

    function moveWindowToWorkspace(address, workspaceId) {
        Hyprland.dispatch(`hl.dsp.window.move({ window = "address:0x${address}", workspace = ${workspaceId}, follow = false })`);
    }

    function windowsForWorkspace(workspaceId) {
        const workspace = Hyprland.workspaces.values.find(ws => ws.id === workspaceId);
        return workspace ? workspace.toplevels.values : [];
    }

    Process {
        id: devicesProcess
        command: ["hyprctl", "devices", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                let devices;
                try {
                    devices = JSON.parse(this.text);
                } catch (e) {
                    console.warn("HyprlandData: could not parse hyprctl devices output:", e);
                    return;
                }
                const mainKeyboard = devices.keyboards?.find(kb => kb.main);
                if (mainKeyboard)
                    root.keyboardLanguage = mainKeyboard.active_keymap.substring(0, 2);
            }
        }
    }

    Component.onCompleted: {
        devicesProcess.running = true;
    }
}
