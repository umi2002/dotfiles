pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick.Layouts

import qs.components

WrapperMouseArea {
    id: root

    required property var modelData
    required property int index
    property bool isHovered: false

    hoverEnabled: true

    onEntered: {
        isHovered = true;
    }

    onExited: {
        isHovered = false;
    }

    ColumnLayout {
        Service {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            service: root.modelData
            isHovered: root.isHovered
        }

        Separator {}
    }
}
