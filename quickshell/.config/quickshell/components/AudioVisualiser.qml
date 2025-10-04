import QtQuick
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

Rectangle {
    implicitHeight: 100

    RowLayout {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 2

        Repeater {
            model: Cava.bars

            delegate: Item {
                id: delegate
                required property int modelData

                Layout.fillWidth: true
                Layout.fillHeight: true

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    height: Math.max(2, parent.height * (delegate.modelData / 100))
                    color: Style.palette.color1
                    radius: 2
                }
            }
        }
    }
}
