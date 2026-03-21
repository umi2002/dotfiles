import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs

WrapperMouseArea {
    id: root
    hoverEnabled: true

    RowLayout {
        id: layout
        anchors.centerIn: parent

        Brightness {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: childrenRect.width
            Layout.preferredHeight: childrenRect.height
        }

        Audio {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: childrenRect.width
            Layout.preferredHeight: childrenRect.height
        }
    }
}
