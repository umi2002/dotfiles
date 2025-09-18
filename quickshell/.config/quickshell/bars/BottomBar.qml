import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

import qs.components
import "../Style.js" as Style

PanelWindow {
    anchors {
        bottom: true
        left: true
        right: true
    }

    implicitHeight: 50

    color: Style.palette.background1

    Rectangle {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        implicitWidth: rowLayout.width + 20
        implicitHeight: rowLayout.height + 5
        radius: height / 2
        color: Style.palette.background2

        RowLayout {
            id: rowLayout
            anchors.centerIn: parent
            spacing: 20

            Battery {
                readonly property UPowerDevice displayDevice: UPower.displayDevice
                readonly property int chargeState: displayDevice.state
                isCharging: chargeState == UPowerDeviceState.Charging || chargeState == UPowerDeviceState.PendingCharge

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: isCharging ? Style.palette.color2 : Style.palette.color3

                value: displayDevice.percentage
                implicitSize: 35
                lineWidth: 4
            }

            Network {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredWidth: childrenRect.width
                Layout.preferredHeight: childrenRect.height
            }
        }
    }
}
