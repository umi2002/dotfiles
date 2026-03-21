pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root

    readonly property real workspaceSpacing: 5
    readonly property int activeWorkspaceIndex: Hyprland.focusedWorkspace?.id - 1

    implicitWidth: workspaceLayout.implicitWidth
    implicitHeight: workspaceLayout.implicitHeight
    color: Style.palette.crust

    RowLayout {
        id: workspaceLayout
        anchors.centerIn: parent
        spacing: root.workspaceSpacing

        Repeater {
            model: HyprlandData.occupiedWorkspaces

            delegate: WorkspaceItem {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                isActive: root.activeWorkspaceIndex === index

                onClicked: {
                    Hyprland.dispatch(`workspace ${index + 1}`);
                }
            }
        }
    }
}
