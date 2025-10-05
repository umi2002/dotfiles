import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.assets
import qs.components
import qs.components.workspaces

Rectangle {
    id: root
    readonly property int margins: 10

    anchors.leftMargin: margins
    anchors.rightMargin: margins
    color: "transparent"

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: root.margins
        spacing: 20

        IconImage {
            source: Assets.archLinux

            implicitSize: 30
            Layout.alignment: Qt.AlignVCenter
        }

        Workspaces {
            Layout.alignment: Qt.AlignVCenter
            radius: Math.min(width, height) / 2

            color: Style.palette.background2
        }
    }

    Title {
        anchors.centerIn: parent
        color: Style.palette.color1
        font.family: Style.font.family1
        font.pointSize: Style.font.size1
    }

    Clock {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        color: Style.palette.color2
        font.family: Style.font.family2
        font.pointSize: Style.font.size2
    }
}
