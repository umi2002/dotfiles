import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.components
import "../Style.js" as Style

WrapperMouseArea {
    id: root
    required property bool popupIsHovered
    readonly property bool isHovered: popupIsHovered || containsMouse
    hoverEnabled: true
    anchors.verticalCenter: parent.verticalCenter

    Rectangle {
        id: system
        implicitWidth: layout.width + 20
        implicitHeight: layout.height + 5
        radius: height / 2
        color: Style.palette.background2

        RowLayout {
            id: layout
            anchors.centerIn: parent
            spacing: 20

            Network {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredWidth: childrenRect.width
                Layout.preferredHeight: childrenRect.height
                implicitSize: 30
            }

            Bluetooth {}
        }
    }
}
