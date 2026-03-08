pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.services

Rectangle {
    id: root

    required property bool isHovered

    implicitWidth: isHovered ? 200 : 0
    implicitHeight: 50
    color: Qt.rgba(Style.palette.background1.r, Style.palette.background1.g, Style.palette.background1.b, 0.88)
    border.width: 1
    border.color: Qt.rgba(Style.palette.color1.r, Style.palette.color1.g, Style.palette.color1.b, 0.6)
    radius: 10
    clip: true

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 400
            easing.type: Easing.InOutBack
        }
    }

    Text {
        text: Battery.timeRemaining
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        font.pointSize: Style.font.size2
        font.family: Style.font.family3
        color: Style.palette.color1
        anchors.fill: parent
        opacity: root.isHovered ? 1 : 0

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }
    }
}
