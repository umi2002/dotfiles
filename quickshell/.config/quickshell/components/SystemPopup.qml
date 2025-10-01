import QtQuick

import qs.components
import "../Style.js" as Style

Rectangle {
    id: root
    required property bool isHovered

    implicitWidth: 500
    implicitHeight: root.isHovered ? 600 : 0
    color: Style.palette.background1
    topRightRadius: 10

    NetworkPopup {
        id: popup
        anchors.top: parent.top
        anchors.topMargin: 10
    }
}
