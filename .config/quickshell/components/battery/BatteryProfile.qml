import Quickshell.Widgets
import Quickshell.Services.UPower
import QtQuick

import qs
import qs.components

WrapperMouseArea {
    id: root

    required property bool isSelected
    required property string iconSource

    cursorShape: Qt.PointingHandCursor

    Rectangle {

        implicitWidth: icon.implicitSize + 10
        implicitHeight: icon.implicitSize + 10
        color: "transparent"

        ColorizedIcon {
            id: icon

            anchors.centerIn: parent
            iconSource: root.iconSource
            iconColor: root.isSelected ? Style.palette.crust : Style.palette.subtext1
            implicitSize: 20
        }
    }
}
