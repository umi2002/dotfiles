import QtQuick

import qs

Item {
    id: root
    property int barValue: 0
    property color barColor: Style.palette.color1

    Rectangle {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: Math.max(2, parent.height * (root.barValue / 100))
        color: root.barColor
        radius: 2
    }
}
