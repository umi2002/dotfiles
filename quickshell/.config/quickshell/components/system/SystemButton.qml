import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs
import qs.components.bluetooth
import qs.components.network

Rectangle {
    id: root
    property bool isExpanded: false

    implicitWidth: layout.width + 20
    implicitHeight: layout.height + 5
    radius: height / 2
    color: "transparent"

    Rectangle {
        id: bgMask
        anchors.fill: parent
        radius: parent.radius
        visible: false
    }

    LinearGradient {
        anchors.fill: parent
        source: bgMask
        start: Qt.point(0, 0)
        end: Qt.point(width, height)
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: root.isExpanded ? Style.palette.border1 : Style.palette.background3

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            GradientStop {
                position: 1.0
                color: root.isExpanded ? Style.palette.color1 : Style.palette.background4

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
        }
    }

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 20

        NetworkIcon {
            id: network
            implicitSize: 30
        }

        BluetoothIcon {
            id: bluetooth
            implicitSize: 30
        }
    }
}
