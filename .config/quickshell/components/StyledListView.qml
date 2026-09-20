pragma ComponentBehavior: Bound

import QtQuick

import qs

Rectangle {
    id: root

    required property var model
    required property Component delegateComponent

    clip: true
    implicitHeight: listView.implicitHeight + 30
    radius: Style.radius.large
    color: "transparent"

    Behavior on implicitHeight {
        NumberAnimation {
            duration: Style.animation.slow
            easing.type: Easing.InOutCubic
        }
    }

    ListView {
        id: listView

        model: root.model
        delegate: root.delegateComponent

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Style.spacing.large
        anchors.rightMargin: Style.spacing.large
        implicitHeight: contentHeight
        interactive: false

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
                duration: Style.animation.slow
                easing.type: Easing.InOutCubic
            }
        }
    }
}
