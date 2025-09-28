import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Style.js" as Style

RowLayout {
    id: root
    required property int value
    required property string icon
    required property var setValueCallback
    property bool isUserInteracting: false

    IconImage {
        id: iconImage
        source: Qt.resolvedUrl(root.icon)
        implicitSize: 30
    }

    Slider {
        id: slider
        value: root.isUserInteracting ? slider.value : root.value
        from: 0
        to: 100
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        implicitWidth: control.implicitWidth
        implicitHeight: control.implicitHeight
        hoverEnabled: true

        Behavior on value {
            NumberAnimation {
                duration: 100
            }
        }

        onPressedChanged: {
            root.isUserInteracting = pressed;
        }

        onMoved: {
            if (!root.setValueCallback) {
                return;
            }

            root.setValueCallback(slider.value);
        }

        HoverHandler {
            cursorShape: Qt.PointingHandCursor
        }

        background: Rectangle {
            id: control
            implicitWidth: root.width - iconImage.width - 20
            implicitHeight: 10
            radius: implicitHeight / 2
            color: Style.palette.background2

            Rectangle {
                implicitWidth: slider.visualPosition * parent.width
                implicitHeight: parent.height
                radius: implicitHeight / 2
                color: Style.palette.color1
            }
        }

        handle: Item {}
    }
}
