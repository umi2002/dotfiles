import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.components

WrapperMouseArea {
    id: root
    required property var backdrop
    property bool isExpanded: false

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
        isExpanded = !isExpanded;
    }

    Connections {
        target: backdrop
        function onFocusLost() {
            root.isExpanded = false;
        }
    }

    Rectangle {
        id: system
        implicitWidth: layout.width + 20
        implicitHeight: layout.height + 5
        radius: height / 2
        color: root.isExpanded ? Style.palette.border1 : Style.palette.background2

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }

        RowLayout {
            id: layout
            anchors.centerIn: parent
            spacing: 20

            Network {
                id: network
                implicitSize: 30
            }

            Bluetooth {
                id: bluetooth
                implicitSize: 30
            }
        }
    }
}
