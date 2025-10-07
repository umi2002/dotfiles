import Quickshell.Widgets
import QtQuick

import qs

WrapperMouseArea {
    cursorShape: Qt.IBeamCursor

    Rectangle {
        implicitWidth: input.implicitWidth
        implicitHeight: input.implicitHeight
        color: "transparent"

        Rectangle {
            id: input
            implicitWidth: 300
            implicitHeight: 30
            radius: 10
            color: Style.palette.border1

            TextInput {
                id: textInput
                anchors.fill: parent
                anchors.margins: 5
                verticalAlignment: Qt.AlignVCenter
                font.pointSize: Style.font.size2
                font.family: Style.font.family3
                color: Style.palette.color1
                activeFocusOnPress: true

                onVisibleChanged: {
                    focus = visible;
                }
            }
        }
    }
}
