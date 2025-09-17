import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

Rectangle {
    id: root
    readonly property real workspaceItemWidth: 30
    readonly property real workspaceSpacing: 5

    Rectangle {
        id: activeIndicator
        width: root.workspaceItemWidth
        height: root.workspaceItemWidth
        radius: width / 2
        color: Style.palette.color1
        z: 1

        anchors.verticalCenter: workspaceLayout.verticalCenter
        x: workspaceLayout.x + HyprlandData.activeWorkspaceIndex * (root.workspaceItemWidth + root.workspaceSpacing)

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
                readonly property bool isActive: Hyprland.focusedWorkspace?.id === index + 1
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

                    UnoccupiedWorkspaceIcon {
                        opacity: !modelData ? 1 : 0
                        anchors.centerIn: parent
                        color: workspace.iconColor

                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 200
                            }
                        }
                    }

                    OccupiedWorkspaceIcon {
                        opacity: modelData ? 1 : 0
                        anchors.centerIn: parent
                        color: workspace.iconColor

                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 200
                            }
                        }
                    }
                }
            }
        }
    }
}
