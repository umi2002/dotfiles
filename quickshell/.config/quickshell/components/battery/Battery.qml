pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

WrapperMouseArea {
    id: root
    hoverEnabled: true

    readonly property real batteryValue: Battery.batteryPercent / 100
    readonly property color batteryColor: Battery.isCharging ? Style.palette.green : Style.palette.red

    implicitWidth: batteryLayout.implicitWidth
    implicitHeight: batteryLayout.implicitHeight

    RowLayout {
        id: batteryLayout
        spacing: 5

        BatteryArcIndicator {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            value: root.batteryValue
            primaryColor: root.batteryColor
        }

        BatteryIndicator {
            value: root.batteryValue
            textColor: root.batteryColor
        }
    }
}
