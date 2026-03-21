import QtQuick
import QtQuick.Shapes

import qs
import qs.components

Item {
    id: root
    width: 300
    height: 40

    property bool isLoading: false
    property bool authFailed: false
    property string selectedUser: ""

    signal submitted(string password)

    Throbber {
        throbberColor: Style.palette.mauve
        visible: root.isLoading
        anchors.centerIn: parent
    }

    Rectangle {
        anchors.fill: parent
        radius: 5
        color: Style.palette.surface0
        visible: !root.isLoading
        border.color: root.authFailed ? Style.palette.red : Style.palette.mauve
        border.width: 2

        Text {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            visible: passwordInput.text.length === 0
            text: "Password"
            font.family: Style.font.family4
            font.pointSize: Style.font.size1
            color: Style.palette.overlay0
        }

        TextInput {
            id: passwordInput
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            focus: true
            echoMode: TextInput.Password
            font.family: Style.font.family4
            font.pointSize: Style.font.size1
            font.letterSpacing: 2
            color: Style.palette.text

            onActiveFocusChanged: {
                if (!activeFocus) {
                    forceActiveFocus();
                }
            }

            Keys.onReturnPressed: {
                if (root.selectedUser === "") {
                    return;
                }
                root.submitted(passwordInput.text);
                passwordInput.text = "";
            }
        }
    }
}
