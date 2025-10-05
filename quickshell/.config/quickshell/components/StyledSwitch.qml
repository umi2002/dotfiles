pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import qs

Switch {
    id: control

    indicator: Rectangle {
        readonly property int margins: 2

        implicitWidth: 40 + margins
        implicitHeight: 25
        anchors.centerIn: parent
        radius: implicitHeight / 2
        color: control.checked ? Style.palette.border1 : Style.palette.background2

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            implicitWidth: 20
            implicitHeight: 20
            radius: implicitWidth / 2
            color: Style.palette.color1
            x: control.checked ? parent.width - width - parent.margins : parent.margins

            Behavior on x {
                NumberAnimation {
                    duration: 200
                }
            }
        }
    }
}
