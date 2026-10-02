pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.components

import qs

ColumnLayout {
    id: root

    required property string title
    required property var servicesModel

    spacing: Style.spacing.normal

    Text {
        text: root.title + " (" + root.servicesModel.length + ")"
        font.pointSize: Style.font.size1
        font.family: Style.font.family1
        color: Style.palette.text
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    }

    StyledListView {
        maximumHeight: 220
        Layout.fillHeight: true
        model: root.servicesModel
        delegateComponent: ServiceListViewItem {
            width: ListView.view.width
        }
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.fillWidth: true
    }
}
