pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick

import qs
import qs.assets
import qs.components
import qs.services

WrapperMouseArea {
    id: root

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
        OverviewState.visible = !OverviewState.visible;
    }

    Rectangle {
        implicitWidth: icon.implicitSize + Style.spacing.large
        implicitHeight: icon.implicitSize + Style.spacing.small
        radius: height / 2
        color: OverviewState.visible ? Style.palette.overlay0 : Style.palette.crust

        Behavior on color {
            ColorAnimation {
                duration: Style.animation.normal
            }
        }

        ColorizedIcon {
            id: icon
            anchors.centerIn: parent
            iconSource: Assets.desktop
            iconColor: OverviewState.visible ? Style.palette.green : Style.palette.text
            implicitSize: 20
        }
    }
}
