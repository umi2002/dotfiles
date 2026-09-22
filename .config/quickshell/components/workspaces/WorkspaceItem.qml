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

    implicitWidth: isActive ? 40 : 20
    implicitHeight: 20
    radius: height / 2
    color: isActive ? Style.palette.green : Style.palette.surface2
    opacity: isActive ? 1 : 0.5

    Behavior on implicitWidth {
        NumberAnimation {
            duration: Style.animation.normal
            easing.bezierCurve: Style.animation.curve
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: Style.animation.normal
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: Style.animation.normal
        }
    }

    ColorizedIcon {
        id: iconImage
        readonly property string desktopIcon: HyprlandData.workspaceIcons[workspaceItem.index + 1] || ""
        readonly property string icon: workspaceItem.modelData ? Assets.workspace.occupied : Assets.workspace.unoccupied

        iconSource: desktopIcon || Qt.resolvedUrl(icon)
        iconColor: workspaceItem.iconColor
        layer.enabled: !desktopIcon
        anchors.centerIn: parent
        implicitSize: 15
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: workspaceItem.clicked()
    }
}
