pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Item {
    id: root

    readonly property bool isHovered: popupMouseArea.containsMouse || batteryMouseArea.containsMouse
    readonly property real batteryValue: Battery.batteryPercent / 100
    readonly property color batteryColor: Battery.isCharging ? Style.palette.color2 : Style.palette.color3

    implicitWidth: batteryLayout.implicitWidth
    implicitHeight: batteryLayout.implicitHeight

    WrapperMouseArea {
        id: popupMouseArea
        hoverEnabled: true
        anchors.left: batteryMouseArea.left
        anchors.bottom: batteryMouseArea.top

        BatteryPopup {
            isHovered: root.isHovered
        }
    }

    WrapperMouseArea {
        id: batteryMouseArea
        hoverEnabled: true

        RowLayout {
            id: batteryLayout
            spacing: 5

            BatteryArcIndicator {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                value: root.batteryValue
                primaryColor: root.batteryColor
                secondaryColor: Style.palette.background2
                iconSource: Battery.batteryIcon
            }

            BatteryIndicator {
                value: root.batteryValue
                textColor: root.batteryColor
            }
        }
    }
}
