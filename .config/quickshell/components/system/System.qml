import Quickshell.Widgets
import QtQuick

WrapperMouseArea {
    id: root
    property bool isExpanded: false

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
        isExpanded = !isExpanded;
    }

    SystemButton {
        isExpanded: root.isExpanded
    }
}
