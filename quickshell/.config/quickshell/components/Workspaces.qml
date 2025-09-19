pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

Rectangle {
    id: root
    readonly property real workspaceItemWidth: 30
    readonly property real workspaceSpacing: 5
    readonly property int activeWorkspaceIndex: Hyprland.focusedWorkspace?.id - 1

    Rectangle {
        id: activeIndicator
        width: root.workspaceItemWidth
        height: root.workspaceItemWidth
        radius: width / 2
        color: Style.palette.color1
        z: 1

        anchors.verticalCenter: workspaceLayout.verticalCenter
        x: workspaceLayout.x + root.activeWorkspaceIndex * (root.workspaceItemWidth + root.workspaceSpacing)

        Behavior on x {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    }

    RowLayout {
        id: workspaceLayout
        anchors.centerIn: parent
        spacing: root.workspaceSpacing
        z: 2

        Repeater {
            id: repeater
            model: HyprlandData.occupiedWorkspaces

            delegate: Rectangle {
                id: workspace
                required property int index
                required property var modelData
                readonly property bool isActive: root.activeWorkspaceIndex === workspace.index
                readonly property string iconColor: isActive ? Style.palette.background1 : Style.palette.color1

                Layout.preferredWidth: root.workspaceItemWidth
                Layout.preferredHeight: root.workspaceItemWidth
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: "transparent"
                opacity: isActive ? 1 : 0.5

                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                    }
                }

                IconImage {
                    id: iconImage
                    property string desktopIcon
                    readonly property string icon: workspace.modelData ? "../assets/occupied_workspace_icon.svg" : "../assets/unoccupied_workspace_icon.svg"
                    source: desktopIcon || Qt.resolvedUrl(icon)
                    anchors.centerIn: parent
                    implicitSize: 20

                    layer.enabled: !desktopIcon
                    layer.effect: MultiEffect {
                        colorization: 1
                        colorizationColor: workspace.iconColor
                    }

                    Connections {
                        target: HyprlandData

                        function onWindowIconsUpdated() {
                            iconImage.desktopIcon = HyprlandData.windowIcons[workspace.index + 1] || "";
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        Hyprland.dispatch(`workspace ${workspace.index + 1}`);
                    }
                }
            }
        }
    }
}
