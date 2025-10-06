import QtQuick
import QtQuick.Layouts

import qs.services

MediaSection {
    implicitHeight: 100

    RowLayout {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 2

        Repeater {
            model: Cava.bars

            delegate: AudioBar {
                required property int modelData

                Layout.fillWidth: true
                Layout.fillHeight: true
                barValue: modelData
            }
        }
    }
}
