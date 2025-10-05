import QtQuick
import QtQuick.Layouts

import qs
import qs.components
import qs.components.bluetooth
import qs.components.network

Rectangle {
    id: root
    property bool isExpanded: false

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
