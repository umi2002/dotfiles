import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.services

import "../Style.js" as Style

Item {
    id: root
    readonly property bool isHovered: popupMouseArea.containsMouse || mediaMouseArea.containsMouse
    implicitWidth: media.implicitWidth
    implicitHeight: media.implicitHeight

    WrapperMouseArea {
        id: popupMouseArea
        hoverEnabled: true
        anchors.bottom: mediaMouseArea.top
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            implicitWidth: popup.implicitWidth
            implicitHeight: popup.implicitHeight
            color: "transparent"

            MediaPopup {
                id: popup
                isHovered: root.isHovered
                clip: true

                Behavior on implicitHeight {
                    NumberAnimation {
                        duration: 400
                        easing.type: Easing.InOutBack
                    }
                }
            }
        }
    }

    WrapperMouseArea {
        id: mediaMouseArea
        hoverEnabled: true

        RowLayout {
            id: media

            readonly property string title: Media.spotifyPlayer?.trackTitle || ""
            readonly property string artist: Media.spotifyPlayer?.trackArtist || ""

            Text {
                text: media.title || "No song playing"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: Style.palette.color1
                font.family: Style.font.family3
                font.pointSize: Style.font.size1
                visible: Media.spotifyPlayer
            }

            IconImage {
                source: Qt.resolvedUrl("../assets/spotify_logo.svg")
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                implicitSize: 30
            }

            Text {
                text: media.artist || ""
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: Style.palette.color1
                font.family: Style.font.family3
                font.pointSize: Style.font.size1
                visible: Media.spotifyPlayer
            }

            Text {
                text: "Spotify unavailable"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: Style.palette.color1
                font.family: Style.font.family3
                font.pointSize: Style.font.size1
                visible: !Media.spotifyPlayer
            }
        }
    }
}
