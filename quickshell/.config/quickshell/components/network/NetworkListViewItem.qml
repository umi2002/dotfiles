pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick.Layouts

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
        Network {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            networkName: root.modelData
            isHovered: root.isHovered
        }

        Separator {}
    }
}
