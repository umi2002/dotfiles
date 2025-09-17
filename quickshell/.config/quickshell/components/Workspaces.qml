import Quickshell
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
        x: workspaceLayout.x + activeWorkspaceIndex * (root.workspaceItemWidth + root.workspaceSpacing)

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
            model: HyprlandData.occupiedWorkspaces

            Button {
                id: workspace
                readonly property bool isActive: activeWorkspaceIndex === index
                readonly property string iconColor: isActive ? Style.palette.background1 : Style.palette.color1
                onPressed: Hyprland.dispatch(`workspace ${index + 1}`)

                Layout.preferredWidth: root.workspaceItemWidth
                Layout.preferredHeight: root.workspaceItemWidth
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                opacity: isActive ? 1 : 0.5

                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                    }
                }

                background: Rectangle {
                    color: "transparent"

                    IconImage {
                        id: iconImage
                        property string desktopIcon
                        readonly property string icon: modelData ? "../assets/occupied_workspace_icon.svg" : "../assets/unoccupied_workspace_icon.svg"
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
                                iconImage.desktopIcon = HyprlandData.windowIcons[index + 1] || "";
                            }
                        }
                    }
                }
            }
        }
    }
}
