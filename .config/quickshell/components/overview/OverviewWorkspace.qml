pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root

    required property int workspaceId
    required property var overview

    readonly property int rowHeight: 26
    readonly property var windows: HyprlandData.windowsForWorkspace(workspaceId)
    readonly property bool isActive: HyprlandData.activeWorkspaceId === workspaceId
    readonly property int fittingCount: Math.max(0, Math.floor((listArea.height + Style.spacing.small) / (rowHeight + Style.spacing.small)))
    readonly property var visibleWindows: windows.length > fittingCount ? windows.slice(0, Math.max(0, fittingCount - 1)) : windows
    readonly property int hiddenCount: windows.length - visibleWindows.length

    radius: Style.radius.small
    color: root.isActive ? Style.palette.surface1 : Style.palette.mantle
    border.width: root.overview.dragToplevel ? 1 : 0
    border.color: Style.palette.mauve

    Behavior on color {
        ColorAnimation {
            duration: Style.animation.normal
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            HyprlandData.focusWorkspace(root.workspaceId);
            OverviewState.visible = false;
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Style.spacing.small
        spacing: Style.spacing.small

        Text {
            text: root.workspaceId
            color: root.isActive ? Style.palette.green : Style.palette.subtext1
            font.family: Style.font.family1
            font.pointSize: Style.font.size2
            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            id: listArea

            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            Column {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: Style.spacing.small

                Repeater {
                    model: root.visibleWindows

                    delegate: OverviewWindow {
                        required property var modelData

                        toplevel: modelData
                        overview: root.overview
                        width: listArea.width
                        implicitHeight: root.rowHeight
                    }
                }

                Text {
                    visible: root.hiddenCount > 0
                    height: root.rowHeight
                    text: `+${root.hiddenCount} more`
                    color: Style.palette.subtext0
                    font.family: Style.font.family1
                    font.pointSize: Style.font.size2
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
}
