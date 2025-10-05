pragma ComponentBehavior: Bound

import Quickshell.Widgets

WrapperMouseArea {
    id: root
    required property string icon
    required property bool isSelected
    cursorShape: Qt.PointingHandCursor

    IconButton {
        icon: root.icon
        isSelected: root.isSelected
    }
}
