pragma ComponentBehavior: Bound

import QtQuick

import qs.components
import "../Style.js" as Style

Rectangle {
    id: root
    required property var model

    clip: true
    implicitHeight: networks.implicitHeight + 30
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
        model: root.model

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 20
        anchors.rightMargin: 20
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

        delegate: NetworkListViewItem {
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }
}
