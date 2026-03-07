import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs

WrapperMouseArea {
    id: root
    hoverEnabled: true

    Rectangle {
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
                    color: Style.palette.background3
                }
                GradientStop {
                    position: 1.0
                    color: Style.palette.background4
                }
            }
        }

        RowLayout {
            id: layout
            anchors.centerIn: parent
            spacing: 0

            Brightness {
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: childrenRect.width
                Layout.preferredHeight: childrenRect.height
            }

            UtilsSeparator {}

            Audio {
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: childrenRect.width
                Layout.preferredHeight: childrenRect.height
            }
        }
    }
}
