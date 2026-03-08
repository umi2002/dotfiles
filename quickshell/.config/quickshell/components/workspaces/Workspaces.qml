pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs
import qs.services

Rectangle {
    id: root

    readonly property real workspaceItemWidth: 30
    readonly property real workspaceSpacing: 5
    readonly property int activeWorkspaceIndex: Hyprland.focusedWorkspace?.id - 1

    implicitWidth: workspaceLayout.implicitWidth
    implicitHeight: workspaceLayout.implicitHeight
    color: "transparent"

    Rectangle {
        id: bgMask
        anchors.fill: parent
        radius: parent.radius
        visible: false
    }

    LinearGradient {
        anchors.fill: parent
        source: bgMask
        start: Qt.point(0, 0)
        end: Qt.point(width, height)
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Style.palette.background3

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            GradientStop {
                position: 1.0
                color: Style.palette.background4

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
        }
    }

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
