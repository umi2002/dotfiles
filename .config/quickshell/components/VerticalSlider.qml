import QtQuick
import QtQuick.Controls

import qs

Slider {
    id: root
    required property int sliderWidth
    required property int sliderHeight
    property bool isUserInteracting: false
    property var onValueChange: function (newValue) {}
    property int cursorShape: Qt.PointingHandCursor

    orientation: Qt.Vertical

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
        cursorShape: root.cursorShape
    }

    background: Rectangle {
        implicitWidth: root.sliderWidth
        implicitHeight: root.sliderHeight
        radius: implicitWidth / 2
        color: Style.palette.crust

        Rectangle {
            implicitWidth: parent.implicitWidth
            implicitHeight: (1 - root.visualPosition) * parent.implicitHeight
            y: parent.height - height
            radius: implicitWidth / 2
            color: Style.palette.subtext1
        }
    }

    handle: Item {}
}
