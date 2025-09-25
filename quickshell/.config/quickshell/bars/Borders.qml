pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Effects

import "../Style.js" as Style

PanelWindow {
    id: root

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    color: "transparent"

    mask: Region {
        x: 0
        y: 0
        width: root.width
        height: root.height
        intersection: Intersection.Subtract
    }

    Item {
        anchors.fill: parent
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Style.palette.border2
            blurMax: 64
        }

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
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: 50
            z: 1
        }

        Rectangle {
            anchors.fill: parent
            color: Style.palette.background1

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
