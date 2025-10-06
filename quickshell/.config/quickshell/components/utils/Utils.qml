import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs

WrapperMouseArea {
    id: root
    hoverEnabled: true

    Rectangle {
        implicitWidth: layout.width + 20
        implicitHeight: layout.height + 5
        radius: height / 2
        color: Style.palette.background2

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
