import QtQuick
import QtQuick.Controls

import qs

Slider {
    id: root
    property bool isUserInteracting: false
    property var onValueChange: function (newValue) {}
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
        cursorShape: Qt.PointingHandCursor
    }

    background: Rectangle {
        implicitWidth: 10
        implicitHeight: root.implicitHeight
        radius: implicitWidth / 2
        color: Style.palette.border1

        Rectangle {
            implicitWidth: parent.implicitWidth
            implicitHeight: (1 - root.visualPosition) * parent.implicitHeight
            y: parent.height - height
            radius: implicitHeight / 2
            color: Style.palette.color1
        }
    }

    handle: Item {}
}
