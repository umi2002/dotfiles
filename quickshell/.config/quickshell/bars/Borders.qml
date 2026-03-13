pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Effects

import qs
import qs.components.notifications

PanelWindow {
    id: root
    readonly property bool hasPopup: bottomBar.hasPopup || topBar.hasPopup
    focusable: true

    MouseArea {
        id: backdrop
        signal focusLost

        anchors.fill: parent
        z: -1
        onClicked: {
            focusLost();
        }
    }

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    color: "transparent"

    mask: Region {
        x: 0
        y: topBar.height
        width: root.hasPopup ? 0 : root.width
        height: root.hasPopup ? 0 : root.height - topBar.height - bottomBar.height
        intersection: Intersection.Subtract
    }

    NotificationPopup {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 100
        anchors.rightMargin: 20
    }

    Item {
        anchors.fill: parent
        layer.enabled: true

        TopBar {
            id: topBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: 50
            z: 1
        }

        BottomBar {
            id: bottomBar
            backdrop: backdrop
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: 50
            z: 1
        }

        Rectangle {
            anchors.fill: parent
            color: Style.palette.base

            layer.enabled: true
            layer.effect: MultiEffect {
                maskSource: mask
                maskEnabled: true
                maskInverted: true
            }
        }

        Item {
            id: mask

            anchors.fill: parent
            layer.enabled: true
            visible: false

            Rectangle {
                anchors.fill: parent
                anchors.margins: 10
                anchors.topMargin: topBar.implicitHeight
                anchors.bottomMargin: bottomBar.implicitHeight
                radius: 20
            }
        }
    }
}
