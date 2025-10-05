import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.assets
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
                source: Assets.media.skipPrevious
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
                source: Media.spotifyPlayer?.isPlaying ? Assets.media.pause : Assets.media.play
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
                source: Assets.media.skipNext
                implicitSize: root.height - 20
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
