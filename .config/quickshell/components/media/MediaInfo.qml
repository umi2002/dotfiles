pragma ComponentBehavior: Bound

import QtQuick.Layouts

import qs
import qs.services

MediaSection {
    implicitHeight: mediaInfo.implicitHeight + 50

    ColumnLayout {
        id: mediaInfo
        anchors.centerIn: parent
        spacing: Style.spacing.small

        MediaText {
            text: Media.title
            Layout.alignment: Qt.AlignHCenter
            fontSize: Style.font.size1
        }

        MediaText {
            text: Media.artist
            Layout.alignment: Qt.AlignHCenter
            fontSize: Style.font.size2
        }

        MediaText {
            text: Media.album
            Layout.alignment: Qt.AlignHCenter
            fontSize: Style.font.size2
        }
    }
}
