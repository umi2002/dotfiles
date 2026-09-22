pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.services

MediaSection {
    implicitHeight: mediaInfo.implicitHeight + 50

    ColumnLayout {
        id: mediaInfo
        anchors.centerIn: parent
        width: parent.width - Style.spacing.large
        spacing: Style.spacing.small

        ScrollingText {
            text: Media.title
            fontSize: Style.font.size1
            Layout.fillWidth: true
            Layout.preferredHeight: implicitHeight
        }

        ScrollingText {
            text: Media.artist
            fontSize: Style.font.size2
            Layout.fillWidth: true
            Layout.preferredHeight: implicitHeight
        }

        ScrollingText {
            text: Media.album
            fontSize: Style.font.size2
            Layout.fillWidth: true
            Layout.preferredHeight: implicitHeight
        }
    }
}
