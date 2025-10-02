pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

Rectangle {
    id: root
    required property bool isHovered
    readonly property int spacing: 5

    implicitWidth: content.implicitWidth
    implicitHeight: isHovered ? content.implicitHeight : 0
    border.width: 1
    border.color: Style.palette.border1
    color: "#bf" + Style.palette.background1.toString().substring(1)
    radius: 10

    Rectangle {
        id: content
        implicitWidth: layout.implicitWidth + 20
        implicitHeight: layout.implicitHeight + 20
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"

        RowLayout {
            id: layout
            anchors.centerIn: parent
            spacing: root.spacing

            ColumnLayout {
                spacing: root.spacing

                Rectangle {
                    id: mediaArt
                    Layout.preferredWidth: height
                    Layout.preferredHeight: mediaInfoContainer.implicitHeight
                    Layout.alignment: Qt.AlignVCenter
                    color: Style.palette.background2
                    radius: 10

                    ClippingRectangle {
                        anchors.fill: parent
                        anchors.margins: 5
                        radius: Infinity
                        clip: true
                        color: "transparent"

                        Image {
                            anchors.fill: parent
                            source: Media.art
                            sourceSize.width: mediaArt.width * 2
                            sourceSize.height: mediaArt.height * 2
                            smooth: true
                            antialiasing: true
                            fillMode: Image.PreserveAspectCrop
                        }
                    }
                }

                Rectangle {
                    id: controls
                    color: Style.palette.background2
                    radius: 10
                    implicitWidth: mediaArt.width
                    implicitHeight: trackLength.height

                    RowLayout {
                        anchors.fill: parent

                        WrapperMouseArea {
                            Layout.alignment: Qt.AlignHCenter
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                Media.spotifyPlayer?.previous();
                            }

                            IconImage {
                                source: Qt.resolvedUrl("../assets/skip_previous_icon.svg")
                                implicitSize: controls.height - 20
                            }
                        }

                        WrapperMouseArea {
                            Layout.alignment: Qt.AlignHCenter
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                Media.spotifyPlayer?.togglePlaying();
                            }

                            IconImage {
                                source: Qt.resolvedUrl(Media.spotifyPlayer?.isPlaying ? "../assets/pause_icon.svg" : "../assets/play_icon.svg")
                                implicitSize: controls.height - 20
                            }
                        }

                        WrapperMouseArea {
                            Layout.alignment: Qt.AlignHCenter
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                Media.spotifyPlayer?.next();
                            }

                            IconImage {
                                source: Qt.resolvedUrl("../assets/skip_next_icon.svg")
                                implicitSize: controls.height - 20
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }
                }
            }

            ColumnLayout {
                id: rightLayout
                spacing: root.spacing

                Rectangle {
                    id: mediaInfoContainer
                    color: Style.palette.background2
                    radius: 10
                    implicitWidth: 400
                    implicitHeight: mediaInfo.implicitHeight + 50

                    ColumnLayout {
                        id: mediaInfo
                        anchors.centerIn: parent

                        Text {
                            text: Media.title
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                            font.pointSize: Style.font.size1
                            font.family: Style.font.family3
                            color: Style.palette.color1
                        }

                        Text {
                            text: Media.artist
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                            font.pointSize: Style.font.size2
                            font.family: Style.font.family3
                            color: Style.palette.color1
                        }

                        Text {
                            text: Media.album
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                            font.pointSize: Style.font.size2
                            font.family: Style.font.family3
                            color: Style.palette.color1
                        }
                    }
                }

                Rectangle {
                    id: trackLength
                    color: Style.palette.background2
                    radius: 10
                    implicitWidth: rightLayout.width
                    implicitHeight: 50

                    Slider {
                        id: slider
                        property bool isUserInteracting: false

                        anchors.centerIn: parent
                        value: isUserInteracting ? value : Media.position
                        from: 0
                        to: Media.length

                        Behavior on value {
                            NumberAnimation {
                                duration: 100
                            }
                        }

                        onPressedChanged: {
                            slider.isUserInteracting = pressed;
                        }

                        onMoved: {
                            Media.setPosition(value);
                        }

                        HoverHandler {
                            cursorShape: Qt.PointingHandCursor
                        }

                        background: Rectangle {
                            implicitWidth: trackLength.width - 50
                            implicitHeight: 10
                            radius: implicitHeight / 2
                            color: Style.palette.border1

                            Rectangle {
                                implicitWidth: slider.visualPosition * parent.width
                                implicitHeight: parent.height
                                radius: implicitHeight / 2
                                color: Style.palette.color1
                            }
                        }

                        handle: Item {}
                    }
                }
            }
        }
    }
}
