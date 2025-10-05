import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
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
