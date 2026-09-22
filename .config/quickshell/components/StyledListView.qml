pragma ComponentBehavior: Bound

import QtQuick

import qs

Rectangle {
    id: root

    required property var model
    required property Component delegateComponent

    property int margins: Style.spacing.large
    property int padding: 30
    property bool interactive: false
    property int addDuration: Style.animation.popup
    property int displacedDuration: Style.animation.slow
    property int removeDuration: Style.animation.slow

    clip: true
    implicitHeight: listView.implicitHeight + padding
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
        anchors.leftMargin: root.margins
        anchors.rightMargin: root.margins
        implicitHeight: contentHeight
        interactive: root.interactive

        add: Transition {
            NumberAnimation {
                properties: "opacity"
                from: 0
                to: 1
                duration: root.addDuration
                easing.type: Easing.InOutCubic
            }
        }

        displaced: Transition {
            NumberAnimation {
                properties: "y"
                duration: root.displacedDuration
                easing.type: Easing.InOutCubic
            }
        }

        remove: Transition {
            NumberAnimation {
                properties: "opacity"
                to: 0
                duration: root.removeDuration
                easing.type: Easing.InOutCubic
            }
        }
    }
}
