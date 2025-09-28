import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

Rectangle {
    id: root
    required property string component
    readonly property int value: {
        switch (component) {
        case "brightness":
            {
                return Brightness.brightnessPercent;
            }
        case "audio":
            {
                return Audio.volume;
            }
        default:
            {
                return value || 0;
            }
        }
    }
    readonly property string icon: {
        switch (component) {
        case "brightness":
            {
                return Brightness.brightnessIcon;
            }
        case "audio":
            {
                return Audio.volumeIcon;
            }
        default:
            {
                return icon || "";
            }
        }
    }
    readonly property var setValueCallback: {
        switch (component) {
        case "brightness":
            {
                return Brightness.setBrightness;
            }
        case "audio":
            {
                return Audio.setVolume;
            }
        default:
            {
                return setValueCallback || null;
            }
        }
    }
    property bool isUserInteracting: false

    color: Style.palette.background1
    radius: 10

    RowLayout {
        id: layout
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        IconImage {
            id: icon
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

            background: Rectangle {
                id: control
                implicitWidth: root.width - icon.width - 20
                implicitHeight: 15
                radius: implicitHeight / 2
                color: Style.palette.background2

                Rectangle {
                    implicitWidth: slider.visualPosition * parent.width
                    implicitHeight: parent.height
                    radius: height / 2
                    color: Style.palette.color1
                }
            }

            handle: Item {}
        }
    }
}
