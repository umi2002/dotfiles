pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Effects

import qs
import qs.assets
import qs.services

Rectangle {
    id: workspaceItem

    required property int index
    required property var modelData
    property bool isActive: false

    signal clicked

    readonly property string iconColor: isActive ? Style.palette.background1 : Style.palette.color1

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
        readonly property string icon: workspaceItem.modelData ? Assets.workspace.occupied : Assets.workspace.unoccupied

        source: desktopIcon || Qt.resolvedUrl(icon)
        anchors.centerIn: parent
        implicitSize: 20

        layer.enabled: !desktopIcon
        layer.effect: MultiEffect {
            colorization: 1
            colorizationColor: workspaceItem.iconColor
        }

        Connections {
            target: HyprlandData
            function onWorkspaceIconsUpdated() {
                iconImage.desktopIcon = HyprlandData.workspaceIcons[workspaceItem.index + 1] || "";
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: workspaceItem.clicked()
    }
}
