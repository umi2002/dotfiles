pragma ComponentBehavior: Bound

import QtQuick.Layouts

import qs.components

ColumnLayout {
    id: layout
    required property var modelData
    required property int index

    Device {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
        device: layout.modelData
    }

    Separator {}
}
