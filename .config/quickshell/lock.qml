pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Pam
import QtQuick

import qs
import qs.assets
import qs.components.auth

ShellRoot {
    id: shellRoot

    property bool authFailed: false
    property bool isLoading: false
    property string errorMessage: ""
    property string pendingPassword: ""
    readonly property string sessionUser: Quickshell.env("USER") || ""

    function pamErrorMessage(raw) {
        if (!raw)
            return "Authentication failed.";
        const msg = raw.toUpperCase();
        if (msg.includes("AUTH_ERR") || msg.includes("FAILURE"))
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

    function fail(message) {
        shellRoot.isLoading = false;
        shellRoot.pendingPassword = "";
        shellRoot.authFailed = true;
        shellRoot.errorMessage = message;
    }

    function reset() {
        if (pam.active)
            pam.abort();
        shellRoot.isLoading = false;
        shellRoot.authFailed = false;
        shellRoot.errorMessage = "";
        shellRoot.pendingPassword = "";
    }

    IpcHandler {
        target: "lock"

        function lock(): void {
            if (sessionLock.locked)
                return;
            shellRoot.reset();
            sessionLock.locked = true;
        }

        function isLocked(): bool {
            return sessionLock.locked;
        }

        function isSecure(): bool {
            return sessionLock.secure;
        }
    }

    Process {
        id: brightnessProc
    }

    Process {
        id: dpmsProc
    }

    Process {
        id: sessionProc
    }

    IdleMonitor {
        timeout: 540

        onIsIdleChanged: {
            if (isIdle)
                brightnessProc.exec(["sh", "-c", "brillo -O && brillo -u 200000 -S 0"]);
            else
                brightnessProc.exec(["brillo", "-u", "200000", "-I"]);
        }
    }

    IdleMonitor {
        timeout: 600

        onIsIdleChanged: {
            if (isIdle) {
                sessionProc.exec(["loginctl", "lock-session"]);
                dpmsProc.exec(["hyprctl", "dispatch", 'hl.dsp.dpms({ action = "disable" })']);
            } else {
                dpmsProc.exec(["hyprctl", "dispatch", 'hl.dsp.dpms({ action = "enable" })']);
            }
        }
    }

    PamContext {
        id: pam

        config: "quickshell-lock"
        user: shellRoot.sessionUser

        onPamMessage: {
            if (!pam.responseRequired)
                return;
            if (shellRoot.pendingPassword === "") {
                pam.abort();
                return;
            }
            pam.respond(shellRoot.pendingPassword);
            shellRoot.pendingPassword = "";
        }

        onCompleted: result => {
            if (result === PamResult.Success) {
                shellRoot.reset();
                sessionLock.locked = false;
                sessionProc.exec(["loginctl", "unlock-session"]);
                return;
            }
            shellRoot.fail(shellRoot.pamErrorMessage(pam.message));
        }

        onError: error => shellRoot.fail("Authentication service error.")
    }

    WlSessionLock {
        id: sessionLock

        locked: false

        WlSessionLockSurface {
            color: Style.palette.base

            Item {
                anchors.fill: parent
                opacity: 0

                NumberAnimation on opacity {
                    to: 1
                    duration: Style.animation.slow
                    easing.type: Easing.InOutCubic
                }

                Image {
                    anchors.left: banner.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    source: Assets.login_wallpaper
                    fillMode: Image.PreserveAspectCrop
                    sourceSize.height: height
                }

                Rectangle {
                    id: banner

                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: parent.width * 0.28
                    color: Style.palette.crust
                }

                TimeDisplay {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.topMargin: Style.spacing.large
                    anchors.rightMargin: Style.spacing.large
                }

                LoginForm {
                    anchors.centerIn: banner
                    authFailed: shellRoot.authFailed
                    isLoading: shellRoot.isLoading
                    errorMessage: shellRoot.errorMessage
                    selectedUser: shellRoot.sessionUser
                    userList: [shellRoot.sessionUser]
                    onSubmitted: password => {
                        shellRoot.authFailed = false;
                        shellRoot.errorMessage = "";
                        shellRoot.isLoading = true;
                        shellRoot.pendingPassword = password;
                        if (!pam.start())
                            shellRoot.fail("Could not start authentication.");
                    }
                }
            }
        }
    }
}
