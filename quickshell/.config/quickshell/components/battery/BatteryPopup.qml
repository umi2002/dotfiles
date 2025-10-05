pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.services

Rectangle {
    id: root

    required property bool isHovered

    implicitWidth: isHovered ? 200 : 0
    implicitHeight: 50
    color: Style.palette.background1
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
