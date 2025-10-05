pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs

ColumnLayout {
    id: root

    required property string title
    required property var networkModel
    required property bool isVisible

    spacing: 10
    opacity: isVisible ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: 200
        }
    }

    Text {
        text: root.title
        font.pointSize: Style.font.size1
        font.family: Style.font.family1
        color: Style.palette.color1
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    }

    NetworkListView {
        model: root.networkModel
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.fillWidth: true
    }
}
