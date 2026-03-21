import QtQuick

import qs
import qs.services

Item {
    id: root
    property double barValue: 0
    property color barColor: Style.palette.subtext1

    Rectangle {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: Math.max(2, parent.height * root.barValue)
        color: root.barColor
        radius: 2
    }
}
