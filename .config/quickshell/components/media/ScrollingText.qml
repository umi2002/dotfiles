pragma ComponentBehavior: Bound

import QtQuick

import qs

Item {
    id: root

    property string text: ""
    property int fontSize: Style.font.size1
    property string fontFamily: Style.font.family3
    property color textColor: Style.palette.text
    property int maximumWidth: 0
    property int scrollSpeed: 40
    property int pauseDuration: 1500

    readonly property bool overflowing: label.implicitWidth > width

    implicitWidth: maximumWidth > 0 ? Math.min(label.implicitWidth, maximumWidth) : 0
    implicitHeight: label.implicitHeight
    clip: true

    Text {
        id: label

        text: root.text
        font.pointSize: root.fontSize
        font.family: root.fontFamily
        color: root.textColor
        verticalAlignment: Text.AlignVCenter
        height: root.height

        onTextChanged: {
            scrollAnimation.restart();
        }
    }

    Binding {
        target: label
        property: "x"
        value: (root.width - label.implicitWidth) / 2
        when: !root.overflowing
    }

    SequentialAnimation {
        id: scrollAnimation

        running: root.overflowing
        loops: Animation.Infinite

        PauseAnimation {
            duration: root.pauseDuration
        }

        NumberAnimation {
            target: label
            property: "x"
            from: 0
            to: Math.min(0, root.width - label.implicitWidth)
            duration: Math.max(1, (label.implicitWidth - root.width) / root.scrollSpeed * 1000)
            easing.type: Easing.Linear
        }

        PauseAnimation {
            duration: root.pauseDuration
        }

        NumberAnimation {
            target: label
            property: "x"
            from: Math.min(0, root.width - label.implicitWidth)
            to: 0
            duration: Math.max(1, (label.implicitWidth - root.width) / root.scrollSpeed * 1000)
            easing.type: Easing.Linear
        }
    }
}
