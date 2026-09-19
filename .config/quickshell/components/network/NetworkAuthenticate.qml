pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick

import qs

WrapperMouseArea {
    id: root
    property bool failed: false
    property bool showInput: true
    property bool busy: false
    property string errorText: ""

    signal submitted(string password)

    function submit() {
        if (root.busy || textInput.text.length === 0)
            return;
        root.submitted(textInput.text);
        textInput.text = "";
    }

    cursorShape: !root.showInput ? Qt.ArrowCursor : (root.busy ? Qt.BusyCursor : Qt.IBeamCursor)

    Rectangle {
        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight
        color: "transparent"

        Column {
            id: content
            spacing: 8

            Rectangle {
                id: input
                visible: root.showInput
                implicitWidth: 300
                implicitHeight: 30
                radius: Style.radius.small
                opacity: root.busy ? 0.5 : 1
                color: root.failed && textInput.text.length === 0 ? Style.palette.red : Style.palette.subtext1

                TextInput {
                    id: textInput
                    anchors.fill: parent
                    anchors.margins: Style.spacing.small
                    verticalAlignment: Qt.AlignVCenter
                    font.pointSize: Style.font.size2
                    font.family: Style.font.family3
                    color: Style.palette.mantle
                    enabled: !root.busy
                    activeFocusOnPress: true
                    echoMode: TextInput.Password

                    Keys.onReturnPressed: root.submit()
                    Keys.onEnterPressed: root.submit()

                    onVisibleChanged: {
                        focus = visible;
                    }

                    onEnabledChanged: {
                        if (enabled && visible)
                            forceActiveFocus();
                    }
                }
            }

            Text {
                visible: root.errorText.length > 0
                width: 300
                wrapMode: Text.WordWrap
                text: root.errorText
                color: Style.palette.red
                font.pointSize: Style.font.size2
                font.family: Style.font.family3
            }
        }
    }
}
