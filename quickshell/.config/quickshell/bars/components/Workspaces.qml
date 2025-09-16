import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import "sources"
import "../../Style.js" as Style

Rectangle {
    id: root

    RowLayout {
        anchors.centerIn: parent

        Repeater {
            model: Workspaces.occupiedWorkspaces

            Rectangle {
                id: workspaceContainer
                readonly property bool isActive: Hyprland.focusedWorkspace.id === index + 1

                Layout.preferredWidth: workspace.implicitWidth + 10
                Layout.preferredHeight: workspace.implicitWidth + 10
                radius: width / 2

                color: isActive ? Style.palette.color1 : "transparent"

                Text {
                    id: workspace
                    text: modelData ? "" : ""

                    anchors.centerIn: parent

                    color: workspaceContainer.isActive ? Style.palette.background1 : Style.palette.color1
                    font.pointSize: Style.font.size2
                }
            }
        }
    }
}
