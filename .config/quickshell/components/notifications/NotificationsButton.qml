import Quickshell.Widgets
import QtQuick

import qs
import qs.assets
import qs.components

WrapperMouseArea {
    id: root
    property bool isExpanded: false

    cursorShape: Qt.PointingHandCursor

    onClicked: {
        isExpanded = !isExpanded;
    }

    Rectangle {
        implicitWidth: icon.width + 10
        implicitHeight: icon.height + 10
        radius: implicitHeight / 2
        color: root.isExpanded ? Style.palette.overlay0 : Style.palette.crust

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }

        ColorizedIcon {
            id: icon

            anchors.centerIn: parent

            iconSource: Assets.notifications.idle
            iconColor: Style.palette.text
            implicitSize: 30
        }
    }
}
