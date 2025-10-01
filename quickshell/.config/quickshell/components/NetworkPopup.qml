import QtQuick
import QtQuick.Layouts

import qs.components
import qs.services

import "../Style.js" as Style

ColumnLayout {
    spacing: 30

    ColumnLayout {
        spacing: 10

        Text {
            text: "Saved Networks"
            font.pointSize: Style.font.size1
            font.family: Style.font.family1
            color: Style.palette.color1
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        }

        NetworkListView {
            model: Network.knownNetworks
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true
        }
    }

    ColumnLayout {
        spacing: 10

        Text {
            text: "Available Networks"
            font.pointSize: Style.font.size1
            font.family: Style.font.family1
            color: Style.palette.color1
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        }

        NetworkListView {
            model: Network.unknownNetworks
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true
        }
    }
}
