import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import qs

Rectangle {
    id: root

    required property var notification

    readonly property int padding: 50

    implicitWidth: 400
    implicitHeight: 100
    width: 0
    height: 0
    clip: true
    color: "transparent"

    Component.onCompleted: {
        width = implicitWidth;
        height = implicitHeight;
    }

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

    function formatDateTime(time) {
        let date = new Date(time);
        let hours = String(date.getHours()).padStart(2, '0');
        let minutes = String(date.getMinutes()).padStart(2, '0');
        let day = String(date.getDate()).padStart(2, '0');
        let month = String(date.getMonth() + 1).padStart(2, '0');
        return `${hours}:${minutes}     ${day}/${month}`;
    }

    RowLayout {
        id: contentLayout

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        spacing: 10

        Item {
            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
            Layout.alignment: Qt.AlignVCenter

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
            id: textContent
            Layout.fillWidth: true
            spacing: 5

            Rectangle {
                Layout.fillWidth: true
                Layout.maximumHeight: 20
                color: "transparent"
                implicitHeight: 20
                opacity: 0.6

                Text {
                    anchors.left: parent.left
                    text: root.notification?.appName || ""
                    color: Style.palette.lavender
                    font.pointSize: Style.font.size2
                    font.family: Style.font.family1
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                }

                Text {
                    anchors.right: parent.right
                    text: root.formatDateTime(root.notification?.time)
                    color: Style.palette.lavender
                    font.pointSize: Style.font.size2
                    font.family: Style.font.family1
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                }
            }

            Text {
                visible: text.length > 0
                text: root.notification?.summary || ""
                color: Style.palette.text
                font.pointSize: Style.font.size2
                font.bold: true
                font.family: Style.font.family1
                elide: Text.ElideRight
                Layout.fillWidth: true
                Layout.maximumHeight: 40
                wrapMode: Text.WordWrap
            }

            Text {
                visible: text.length > 0
                text: root.notification?.body || ""
                color: Style.palette.lavender
                font.pointSize: Style.font.size2
                font.family: Style.font.family1
                elide: Text.ElideRight
                Layout.fillWidth: true
                Layout.maximumHeight: 20
                wrapMode: Text.WordWrap
            }
        }
    }
}
