import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import qs

Rectangle {
    id: root

    required property var notification

    readonly property int padding: 14

    anchors.centerIn: parent
    implicitWidth: 400
    implicitHeight: contentLayout.implicitHeight + padding * 2
    width: 0
    height: 0
    clip: true
    color: "transparent"

    Behavior on height {
        NumberAnimation {
            duration: 350
            easing.type: Easing.Bezier
            easing.bezierCurve: [0.05, 0.7, 0.1, 1.0, 1.0, 1.0]
        }
    }

    Behavior on width {
        NumberAnimation {
            duration: 350
            easing.type: Easing.Bezier
            easing.bezierCurve: [0.05, 0.7, 0.1, 1.0, 1.0, 1.0]
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
