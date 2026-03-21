pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Services.Greetd
import QtQuick

import qs
import qs.assets
import qs.components.greetd

ShellRoot {
    id: shellRoot

    property bool authFailed: false
    property bool isLoading: false
    property string errorMessage: ""
    property var userList: []
    property int selectedUserIndex: 0
    property string selectedUser: userList.length > 0 ? userList[selectedUserIndex] : ""
    property string pendingPassword: ""

    function pamErrorMessage(raw) {
        if (!raw)
            return "Authentication failed.";
        const msg = raw.toUpperCase();
        if (msg.includes("AUTH_ERR"))
            return "Wrong password.";
        if (msg.includes("USER_UNKNOWN"))
            return "User not found.";
        if (msg.includes("MAXTRIES"))
            return "Too many failed attempts.";
        if (msg.includes("ACCT_EXPIRED"))
            return "Account has expired.";
        if (msg.includes("AUTHTOK_EXPIRED") || msg.includes("NEW_AUTHTOK_REQD"))
            return "Password expired — change it first.";
        if (msg.includes("PERM_DENIED"))
            return "Permission denied.";
        if (msg.includes("AUTHINFO_UNAVAIL"))
            return "Authentication service unavailable.";
        if (msg.includes("AUTHTOK_LOCK_BUSY"))
            return "Authentication token is locked.";
        if (msg.includes("CRED_EXPIRED"))
            return "Credentials have expired.";
        return "Authentication failed.";
    }

    FileView {
        path: "/etc/passwd"
        onLoaded: {
            const lines = text().split('\n');
            const users = [];
            for (const line of lines) {
                const parts = line.split(':');
                if (parts.length < 4)
                    continue;
                const uid = parseInt(parts[2]);
                if (uid >= 1000 && uid < 65534)
                    users.push(parts[0]);
            }
            shellRoot.userList = users;
        }
    }

    Connections {
        target: Greetd

        function onAuthMessage(message, error, responseRequired, echoResponse) {
            shellRoot.authFailed = false;
            shellRoot.errorMessage = "";
            if (responseRequired) {
                Greetd.respond(shellRoot.pendingPassword);
                shellRoot.pendingPassword = "";
            }
        }

        function onReadyToLaunch() {
            shellRoot.isLoading = false;
            Greetd.launch(["start-hyprland"]);
        }

        function onAuthFailure(message) {
            shellRoot.isLoading = false;
            shellRoot.authFailed = true;
            shellRoot.errorMessage = shellRoot.pamErrorMessage(message);
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: win
            required property var modelData

            screen: modelData
            focusable: true

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            color: Style.palette.base

            Image {
                anchors.fill: parent
                source: Assets.login_wallpaper
            }

            TimeDisplay {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 20
                anchors.rightMargin: 20
            }

            LoginForm {
                anchors.centerIn: parent
                authFailed: shellRoot.authFailed
                isLoading: shellRoot.isLoading
                errorMessage: shellRoot.errorMessage
                selectedUser: shellRoot.selectedUser
                userList: shellRoot.userList
                onPrevUser: {
                    shellRoot.authFailed = false;
                    shellRoot.selectedUserIndex = (shellRoot.selectedUserIndex - 1 + shellRoot.userList.length) % shellRoot.userList.length;
                }
                onNextUser: {
                    shellRoot.authFailed = false;
                    shellRoot.selectedUserIndex = (shellRoot.selectedUserIndex + 1) % shellRoot.userList.length;
                }
                onSubmitted: password => {
                    shellRoot.authFailed = false;
                    shellRoot.isLoading = true;
                    shellRoot.pendingPassword = password;
                    Greetd.createSession(shellRoot.selectedUser);
                }
            }
        }
    }
}
