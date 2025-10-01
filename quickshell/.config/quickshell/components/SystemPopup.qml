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
        readonly property int margins: 30
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: margins
        anchors.leftMargin: margins
        anchors.rightMargin: margins
    }
}
