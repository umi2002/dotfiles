import Quickshell.Services.UPower
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.components
import "../Style.js" as Style

Rectangle {
    id: root
    readonly property int margins: 10

    anchors.leftMargin: margins
    anchors.rightMargin: margins
    color: "transparent"

    Rectangle {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: info.width + 20
        implicitHeight: info.height + 5
        radius: height / 2
        color: Style.palette.background2

        RowLayout {
            id: info
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
                implicitSize: 30
            }
        }
    }

    Media {
        anchors.centerIn: parent
    }

    Rectangle {
        anchors.right: language.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: root.margins
        implicitWidth: utils.width + 20
        implicitHeight: utils.height + 5
        radius: height / 2
        color: Style.palette.background2

        RowLayout {
            id: utils
            anchors.centerIn: parent

            Brightness {
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: childrenRect.width
                Layout.preferredHeight: childrenRect.height
            }

            Rectangle {
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: 2
                Layout.preferredHeight: parent.height - 5
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                color: Style.palette.color1
            }

            Audio {
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: childrenRect.width
                Layout.preferredHeight: childrenRect.height
            }
        }
    }

    Language {
        id: language
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }
}
