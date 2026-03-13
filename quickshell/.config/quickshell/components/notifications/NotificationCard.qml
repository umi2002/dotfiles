import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import qs
import qs.assets

Rectangle {
    id: root

    required property var notification

    signal dismissed

    readonly property int padding: 14

    anchors.centerIn: parent
    implicitWidth: 400
    implicitHeight: contentLayout.implicitHeight + padding * 2
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.dismissed();
        }
    }

    RowLayout {
        id: contentLayout

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: root.padding
        }

        spacing: 10

        Item {
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
            Layout.alignment: Qt.AlignTop

            Image {
                id: notifImage
                anchors.fill: parent
                source: root.notification?.image || ""
                visible: status === Image.Ready
            }

            IconImage {
                anchors.fill: parent
                source: Quickshell.iconPath(root.notification?.appIcon || "")
                visible: notifImage.status !== Image.Ready
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            Text {
                text: root.notification?.appName || ""
                color: Style.palette.mantle
                font.pointSize: Style.font.size2
                font.family: Style.font.family1
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            Text {
                visible: text.length > 0
                text: root.notification?.summary || ""
                color: Style.palette.crust
                font.pointSize: Style.font.size2
                font.bold: true
                font.family: Style.font.family1
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }

            Text {
                visible: text.length > 0
                text: root.notification?.body || ""
                color: Style.palette.mantle
                font.pointSize: Style.font.size2
                font.family: Style.font.family1
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }
        }
    }
}
