pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.services

Rectangle {
    id: root

    clip: true
    implicitHeight: batteryText.implicitHeight
    color: "transparent"

    Text {
        id: batteryText
        text: BluetoothData.batteryPercent.toString() + "% Battery"
        font.pointSize: Style.font.size2
        font.family: Style.font.family3
        color: Style.palette.color1
    }
}
