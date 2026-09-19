pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.components

import qs

ColumnLayout {
    id: root

    required property string title
    required property var networkModel
    required property bool isVisible

    spacing: Style.spacing.normal
    opacity: isVisible ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: Style.animation.normal
        }
    }

    Text {
        text: root.title
        font.pointSize: Style.font.size1
        font.family: Style.font.family1
        color: Style.palette.text
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    }

    StyledListView {
        model: root.networkModel
        delegateComponent: NetworkListViewItem {
            width: ListView.view.width
        }
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.fillWidth: true
    }
}
