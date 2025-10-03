import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.services

Rectangle {
    id: root

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
                implicitSize: root.height - 20
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
                implicitSize: root.height - 20
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
                implicitSize: root.height - 20
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
