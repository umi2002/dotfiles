import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.components
import "../Style.js" as Style

PanelWindow {
    id: topBar
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 50

    color: Style.palette.background1

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        spacing: 20

        IconImage {
            source: Qt.resolvedUrl("../assets/arch_linux_icon.svg")

            implicitSize: 30
            Layout.alignment: Qt.AlignVCenter
        }

        Workspaces {
            Layout.preferredWidth: childrenRect.width + 40
            Layout.preferredHeight: childrenRect.height + 5
            Layout.alignment: Qt.AlignVCenter
            radius: Math.min(width, height) / 2

            color: Style.palette.background2
        }
    }

    Text {
        text: Hyprland.activeToplevel?.title || ""
        anchors.centerIn: parent
        color: Style.palette.color1
        font.family: Style.font.family
        font.pointSize: Style.font.size1
    }

    Clock {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10

        color: Style.palette.color2
        font.family: Style.font.family
        font.pointSize: Style.font.size2
    }
}
