pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs

WrapperMouseArea {
    id: root

    required property string label
    required property bool checked

    signal toggled

    cursorShape: Qt.PointingHandCursor

    onClicked: root.toggled()

    RowLayout {
        Text {
            text: root.label
            font.pointSize: Style.font.size1
            font.family: Style.font.family1
            color: Style.palette.text
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        StyledSwitch {
            checked: root.checked
            enabled: false
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }
    }
}
