import QtQuick
import QtQuick.Layouts

import qs

ColumnLayout {
    id: root
    spacing: 15

    property bool authFailed: false
    property bool isLoading: false
    property string errorMessage: ""
    property string selectedUser: ""
    property var userList: []

    signal prevUser
    signal nextUser
    signal submitted(string password)

    UserAvatar {
        Layout.alignment: Qt.AlignHCenter
        Layout.bottomMargin: 20
        opacity: root.isLoading ? 0 : 1
        selectedUser: root.selectedUser
    }

    UserSelector {
        Layout.alignment: Qt.AlignHCenter
        opacity: root.isLoading ? 0 : 1
        selectedUser: root.selectedUser
        userList: root.userList
        onPrevUser: root.prevUser()
        onNextUser: root.nextUser()
    }

    Text {
        Layout.alignment: Qt.AlignHCenter
        opacity: root.authFailed ? 1 : 0
        text: root.errorMessage || "Authentication failed"
        font.family: Style.font.family4
        font.pointSize: Style.font.size2
        color: Style.palette.red
    }

    PasswordField {
        Layout.alignment: Qt.AlignHCenter
        isLoading: root.isLoading
        authFailed: root.authFailed
        selectedUser: root.selectedUser
        onSubmitted: password => root.submitted(password)
    }
}
