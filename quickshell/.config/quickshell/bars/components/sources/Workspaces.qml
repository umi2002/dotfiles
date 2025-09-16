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

    function updateOccupiedWorkspaces() {
        occupiedWorkspaces = Array.from({
            length: 10
        }, (_, i) => {
            return Hyprland.workspaces.values.some(workspace => {
                return workspace.id === i + 1;
            });
        });
    }

    Component.onCompleted: updateOccupiedWorkspaces()

    Connections {
        target: Hyprland

        function onFocusedWorkspaceChanged() {
            root.updateOccupiedWorkspaces();
        }
    }

    Connections {
        target: Hyprland.workspaces

        function onValuesChanged() {
            root.updateOccupiedWorkspaces();
        }
    }
}
