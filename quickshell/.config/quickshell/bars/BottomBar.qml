import Quickshell
import Quickshell.Services.UPower
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

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        spacing: 20

        Battery {
            readonly property UPowerDevice displayDevice: UPower.displayDevice
            readonly property int chargeState: displayDevice.state
            readonly property bool isCharging: chargeState == UPowerDeviceState.Charging || chargeState == UPowerDeviceState.PendingCharge

            Layout.alignment: Qt.AlignVCenter
            color: isCharging ? Style.palette.color2 : Style.palette.color1

            value: displayDevice.percentage
            implicitSize: 40
            lineWidth: 4
        }
    }
}
