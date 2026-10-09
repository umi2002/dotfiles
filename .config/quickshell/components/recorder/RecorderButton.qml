pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.assets
import qs.components
import qs.services

WrapperMouseArea {
    id: root

    required property string screenName

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
        if (Recorder.recording) {
            Recorder.stop();
            return;
        }
        if (Recorder.starting) {
            Recorder.cancel();
            return;
        }
        if (!RecorderState.visible)
            RecorderState.targetScreen = root.screenName;
        RecorderState.visible = !RecorderState.visible;
    }

    Rectangle {
        implicitWidth: layout.implicitWidth + Style.spacing.large
        implicitHeight: icon.implicitSize + Style.spacing.small
        radius: height / 2
        color: Recorder.recording ? Style.palette.surface0 : (RecorderState.visible ? Style.palette.overlay0 : Style.palette.crust)

        Behavior on color {
            ColorAnimation {
                duration: Style.animation.normal
            }
        }

        RowLayout {
            id: layout

            anchors.centerIn: parent
            spacing: Style.spacing.small

            Loader {
                active: Recorder.starting
                visible: active
                Layout.alignment: Qt.AlignVCenter

                sourceComponent: Throbber {
                    size: 18
                    strokeWidth: 2
                    throbberColor: Style.palette.yellow
                }
            }

            ColorizedIcon {
                id: icon

                visible: !Recorder.starting

                iconSource: Recorder.recording ? Assets.recorder.stop : Assets.recorder.record
                iconColor: Recorder.recording ? Style.palette.red : (Recorder.starting ? Style.palette.yellow : (RecorderState.visible ? Style.palette.green : Style.palette.text))
                implicitSize: 20
                Layout.alignment: Qt.AlignVCenter

                Behavior on iconColor {
                    ColorAnimation {
                        duration: Style.animation.normal
                    }
                }

            }

            Text {
                visible: Recorder.recording
                text: Recorder.elapsedLabel
                font.pointSize: Style.font.size2
                font.family: Style.font.family2
                color: Style.palette.red
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }
}
