import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Style.js" as Style

Rectangle {
    id: root
    required property real value
    required property string icon

    color: Style.palette.background1
    radius: 10

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: layout.width
        implicitHeight: layout.height
        color: "transparent"

        RowLayout {
            id: layout
            anchors.centerIn: parent

            IconImage {
                id: icon
                source: Qt.resolvedUrl(root.icon)
                implicitSize: 30
            }

            ProgressBar {
                id: progressBar
                value: root.value
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                implicitWidth: control.implicitWidth
                implicitHeight: control.implicitHeight

                Behavior on value {
                    NumberAnimation {
                        duration: 100
                    }
                }

                background: Rectangle {
                    id: control
                    implicitWidth: root.width - icon.width - 20
                    implicitHeight: 15
                    radius: implicitHeight / 2
                    color: Style.palette.background2
                }

                contentItem: Item {
                    Rectangle {
                        implicitWidth: progressBar.visualPosition * parent.width
                        implicitHeight: parent.height
                        radius: height / 2
                        color: Style.palette.color1
                    }
                }
            }
        }
    }
}
