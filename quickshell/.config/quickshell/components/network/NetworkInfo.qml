pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.services

Rectangle {
    id: root

    clip: true
    implicitHeight: networkInfo.implicitHeight
    color: "transparent"

    Text {
        id: networkInfo
        text: Network.connectedNetworkInfo
        font.pointSize: Style.font.size2
        font.family: Style.font.family3
        color: Style.palette.color1
    }
}
