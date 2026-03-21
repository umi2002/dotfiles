pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.assets
import qs.components
import qs.services

Rectangle {
    id: root
    property bool isExpanded
    readonly property int spacing: 5
    readonly property int margins: 20

    implicitWidth: 450
    implicitHeight: layout.implicitHeight + margins

    radius: 10
    clip: true
    color: Style.palette.base

    function animateClearAll() {
        for (let i = 0; i < listView.count; i++)
            listView.itemAtIndex(i)?.animateOut();
        clearTimer.start();
    }

    Timer {
        id: clearTimer
        interval: 350
        onTriggered: {
            Notifications.history.clear();
            Notifications.dismissAll();
        }
    }

    ColumnLayout {
        id: layout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: root.margins

        Rectangle {
            Layout.leftMargin: 10
            Layout.bottomMargin: 10
            Layout.preferredWidth: titleLayout.implicitWidth
            Layout.preferredHeight: 40
            color: "transparent"

            RowLayout {
                id: titleLayout
                spacing: 10

                ColorizedIcon {
                    iconSource: Assets.notifications.idle
                    iconColor: Style.palette.lavender
                    implicitSize: 30
                }

                Text {
                    id: title
                    text: "Notifications"
                    color: Style.palette.lavender
                    font.family: Style.font.family2
                    font.pixelSize: Style.font.size1
                }
            }

            Rectangle {
                anchors.top: titleLayout.bottom
                anchors.topMargin: 5
                x: title.x + title.implicitWidth / 2 - implicitWidth / 2
                color: Style.palette.mauve
                implicitWidth: 100
                implicitHeight: 4
                radius: implicitHeight / 2
            }
        }

        ListView {
            id: listView
            model: Notifications.history
            spacing: root.spacing
            clip: true
            Layout.preferredHeight: contentHeight
            Layout.maximumHeight: 600
            Layout.fillWidth: true

            displaced: Transition {
                NumberAnimation {
                    properties: "y"
                    duration: 400
                    easing.type: Easing.Bezier
                    easing.bezierCurve: [0.05, 0.7, 0.1, 1.0, 1.0, 1.0]
                }
            }

            delegate: Item {
                id: delegateItem
                required property var model
                clip: true
                width: listView.width
                height: card.implicitHeight

                function animateOut() {
                    card.height = 0;
                    card.width = 0;
                }

                NotificationHistoryCard {
                    id: card
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    notification: delegateItem.model
                    color: Style.palette.mantle
                    radius: 10
                }
            }
        }

        RowLayout {
            id: controls
            implicitHeight: 50
            Layout.fillWidth: true
            Layout.topMargin: 10
            Layout.leftMargin: 10

            WrapperMouseArea {
                cursorShape: Qt.PointingHandCursor

                onClicked: root.animateClearAll()

                Rectangle {
                    color: Style.palette.crust
                    implicitWidth: clearLayout.implicitWidth + 20
                    implicitHeight: clearLayout.implicitHeight + 10
                    radius: implicitHeight / 2

                    RowLayout {
                        id: clearLayout
                        anchors.centerIn: parent

                        ColorizedIcon {
                            id: icon
                            iconSource: Assets.notifications.clearNotifications
                            iconColor: Style.palette.lavender
                            implicitSize: 30
                        }

                        Text {
                            text: "Clear"
                            color: Style.palette.lavender
                            font.family: Style.font.family2
                            font.pixelSize: Style.font.size2
                        }
                    }
                }
            }
        }
    }
}
