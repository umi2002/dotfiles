pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    property list<bool> occupiedWorkspaces: Array.from({
        length: 10
    }, () => {
        return false;
    })
    readonly property int activeWorkspaceIndex: Hyprland.focusedWorkspace?.id - 1
    function updateWorkspaces() {
        let workspaces = Hyprland.workspaces?.values;

        if (!workspaces) {
            return;
        }

        workspaces.forEach(workspace => {
            occupiedWorkspaces[workspace.id - 1] = workspace.toplevels?.values.length !== 0;
        });
    }

    Component.onCompleted: updateWorkspaces()

    Connections {
        target: Hyprland

        function onFocusedWorkspaceChanged() {
            root.updateWorkspaces();
        }
    }

    Connections {
        target: Hyprland.workspaces

        function onValuesChanged() {
            root.updateWorkspaces();
        }
    }
}
