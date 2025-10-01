import QtQuick
import QtQuick.Controls

import qs.components
import "../Style.js" as Style

Rectangle {
    id: root
    required property bool isHovered

    implicitWidth: 500
    implicitHeight: root.isHovered ? 600 : 0
    color: Style.palette.background1
    topRightRadius: 10

    ScrollView {
        id: scrollView
        anchors.fill: parent
        anchors.margins: 30
        clip: true

        NetworkPopup {
            width: scrollView.width
        }
    }
}
