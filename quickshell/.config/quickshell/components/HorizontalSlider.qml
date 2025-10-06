import QtQuick
import QtQuick.Controls

import qs

Slider {
    id: root
    property int sliderWidth: 200
    property int sliderHeight: 10
    orientation: Qt.Horizontal

    background: Rectangle {
        implicitWidth: root.sliderWidth
        implicitHeight: root.sliderHeight
        radius: implicitHeight / 2
        color: Style.palette.border1

        Rectangle {
            implicitWidth: root.visualPosition * parent.implicitWidth
            implicitHeight: parent.implicitHeight
            radius: implicitHeight / 2
            color: Style.palette.color1
        }
    }

    handle: Item {}
}
