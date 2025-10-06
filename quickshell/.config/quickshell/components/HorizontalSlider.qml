import QtQuick
import QtQuick.Controls

import qs

Slider {
    id: root
    required property int sliderWidth
    required property int sliderHeight
    property bool isUserInteracting: false
    property var onValueChange: function (newValue) {}

    orientation: Qt.Horizontal

    onPressedChanged: {
        root.isUserInteracting = pressed;
        if (pressed) {
            root.value = root.value;
        }
    }

    onMoved: {
        onValueChange(value);
    }

    HoverHandler {
        cursorShape: Qt.PointingHandCursor
    }

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
