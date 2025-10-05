pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root

    readonly property real workspaceItemWidth: 30
    readonly property real workspaceSpacing: 5
    readonly property int activeWorkspaceIndex: Hyprland.focusedWorkspace?.id - 1

    implicitWidth: workspaceLayout.implicitWidth
    implicitHeight: workspaceLayout.implicitHeight

    WorkspaceIndicator {
        id: activeIndicator
        activeIndex: root.activeWorkspaceIndex
        itemWidth: root.workspaceItemWidth
        itemSpacing: root.workspaceSpacing
        layoutX: workspaceLayout.x
        anchors.verticalCenter: parent.verticalCenter
    }

    RowLayout {
        id: workspaceLayout
        anchors.fill: parent
        spacing: root.workspaceSpacing

        Repeater {
            model: HyprlandData.occupiedWorkspaces

            delegate: WorkspaceItem {

                Layout.preferredWidth: root.workspaceItemWidth
                Layout.preferredHeight: root.workspaceItemWidth
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                isActive: root.activeWorkspaceIndex === index

                onClicked: {
                    Hyprland.dispatch(`workspace ${index + 1}`);
                }
            }
        }
    }
}
