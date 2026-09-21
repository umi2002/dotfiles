pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.services

MediaSection {
    implicitHeight: 100

    Component.onCompleted: Cava.acquire()
    Component.onDestruction: Cava.release()

    RowLayout {
        anchors.fill: parent
        anchors.margins: Style.spacing.small
        spacing: 2

        Repeater {
            model: Array.from({
                length: Cava.bars
            }, (_, i) => i)

            delegate: AudioBar {
                required property double modelData

                Layout.fillWidth: true
                Layout.fillHeight: true
                barValue: Math.max(1e-3, Math.min(1, Cava.values[modelData] ?? 0))
            }
        }
    }
}
