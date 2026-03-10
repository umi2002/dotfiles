pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Effects

import qs
import qs.assets
import qs.components
import qs.services

Rectangle {
    id: workspaceItem

    required property int index
    required property var modelData
    property bool isActive: false

    signal clicked

    readonly property string iconColor: isActive ? Style.palette.crust : Style.palette.text

    color: "transparent"
    opacity: isActive ? 1 : 0.5

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

    ColorizedIcon {
        id: iconImage
        property string desktopIcon
        readonly property string icon: workspaceItem.modelData ? Assets.workspace.occupied : Assets.workspace.unoccupied

        iconSource: desktopIcon || Qt.resolvedUrl(icon)
        iconColor: workspaceItem.iconColor
        layer.enabled: !desktopIcon
        anchors.centerIn: parent
        implicitSize: 20

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
