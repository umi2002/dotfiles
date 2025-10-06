import QtQuick.Layouts

import qs
import qs.services

Section {
    implicitHeight: mediaInfo.implicitHeight + 50

    ColumnLayout {
        id: mediaInfo
        anchors.centerIn: parent
        spacing: 5

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
