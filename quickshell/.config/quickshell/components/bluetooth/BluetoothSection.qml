pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.services

ColumnLayout {
    id: root
    required property string title
    required property var bluetoothModel
    required property bool isVisible

    opacity: isVisible ? 1 : 0
    spacing: 10

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

    BluetoothListView {
        model: root.bluetoothModel
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.fillWidth: true
    }
}
