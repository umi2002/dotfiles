pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property int nWorkspaces: 10

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
            Hyprland.dispatch(`hl.dsp.focus({ window = "address:0x${toplevel.address}" })`);
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
        devicesProcess.running = true;
    }
}
