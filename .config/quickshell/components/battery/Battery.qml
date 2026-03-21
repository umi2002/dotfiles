pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.assets
import qs.components
import qs.services

WrapperMouseArea {
    id: root
    hoverEnabled: true

    readonly property real batteryValue: Battery.batteryPercent / 100
    readonly property color batteryColor: Battery.isCharging ? Style.palette.green : Style.palette.red

    implicitWidth: Battery.displayDevice.isLaptopBattery ? batteryLoader.implicitWidth : desktopLoader.implicitWidth
    implicitHeight: Battery.displayDevice.isLaptopBattery ? batteryLoader.implicitHeight : desktopLoader.implicitHeight

    Rectangle {
        anchors.centerIn: parent
        color: "transparent"

        Loader {
            id: desktopLoader
            active: !Battery.displayDevice.isLaptopBattery

            sourceComponent: ColorizedIcon {
                iconSource: Assets.desktop
                iconColor: Style.palette.text
                implicitSize: 30
            }
        }

        Loader {
            id: batteryLoader
            active: Battery.displayDevice.isLaptopBattery

            sourceComponent: RowLayout {
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
    }
}
