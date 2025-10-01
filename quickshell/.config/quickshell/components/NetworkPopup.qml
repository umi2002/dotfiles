import QtQuick
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

Rectangle {
    clip: true
    implicitWidth: networks.implicitWidth + 20
    implicitHeight: networks.implicitHeight + 20
    radius: 20
    color: Style.palette.background2

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutCubic
        }
    }

    ListView {
        id: networks
        model: Network.networks

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 20
        implicitWidth: contentWidth
        implicitHeight: contentHeight

        add: Transition {
            NumberAnimation {
                properties: "opacity"
                from: 0
                to: 1
                duration: 500
                easing.type: Easing.InOutCubic
            }
        }

        displaced: Transition {
            NumberAnimation {
                properties: "y"
                duration: 400
                easing.type: Easing.InOutCubic
            }
        }

        remove: Transition {
            NumberAnimation {
                properties: "opacity"
                to: 0
                duration: 300
                easing.type: Easing.InOutCubic
            }
        }

        delegate: Text {
            required property var modelData
            text: modelData.ssid
            font.pointSize: Style.font.size2
            font.family: Style.font.family3
            color: Style.palette.color1
        }
    }
}
