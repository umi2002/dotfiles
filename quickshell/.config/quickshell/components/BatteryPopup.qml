import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root
    required property bool isHovered

    clip: true
    implicitWidth: isHovered ? 200 : 0
    implicitHeight: 50
    color: Style.palette.background1
    topRightRadius: 10

    Text {
        id: info
        text: Battery.timeToEmpty || Battery.timeToFull
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
