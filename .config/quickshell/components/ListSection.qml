pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs

ColumnLayout {
    id: root

    required property string title
    required property var sectionModel
    required property Component delegateComponent

    property bool isVisible: true
    property int maximumHeight: 200

    readonly property real naturalHeight: titleText.implicitHeight + root.spacing + listView.naturalHeight

    Layout.maximumHeight: root.naturalHeight

    spacing: Style.spacing.normal
    opacity: root.isVisible ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: Style.animation.normal
        }
    }

    Text {
        id: titleText

        text: root.title
        font.pointSize: Style.font.size1
        font.family: Style.font.family1
        color: Style.palette.text
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    }

    StyledListView {
        id: listView

        maximumHeight: root.maximumHeight
        model: root.sectionModel
        delegateComponent: root.delegateComponent
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    }
}
