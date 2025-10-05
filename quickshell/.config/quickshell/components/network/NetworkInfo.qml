pragma ComponentBehavior: Bound

import QtQuick

import qs

Rectangle {
    id: root

    required property string infoText

    clip: true
    implicitHeight: networkInfo.implicitHeight
    color: "transparent"

    Text {
        id: networkInfo
        text: root.infoText
        font.pointSize: Style.font.size2
        font.family: Style.font.family3
        color: Style.palette.color1
    }
}
