import Quickshell.Widgets
import QtQuick

WrapperMouseArea {
    id: root
    required property var backdrop
    property bool isExpanded: false

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
        isExpanded = !isExpanded;
    }

    Connections {
        target: root.backdrop
        function onFocusLost() {
            root.isExpanded = false;
        }
    }

    SystemButton {
        isExpanded: root.isExpanded
    }
}
