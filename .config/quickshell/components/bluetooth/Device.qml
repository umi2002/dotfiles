pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.services

Rectangle {
    id: root
    required property var device
    required property bool isHovered

    clip: true
    implicitHeight: deviceHeader.implicitHeight + (deviceHeader.isExpanded ? deviceInfoLoader.implicitHeight + Style.spacing.large : 0)
    color: "transparent"

    Behavior on implicitHeight {
        NumberAnimation {
            duration: Style.animation.slow
            easing.type: Easing.InOutCubic
        }
    }

    DeviceHeader {
        id: deviceHeader
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        device: root.device
        isHovered: root.isHovered

        onActionTriggered: {
            if (root.device?.pairing) {
                root.device.cancelPair();
                return;
            }
            if (!(root.device?.paired || root.device?.bonded)) {
                root.device.pair();
                return;
            }
            if (root.device.connected)
                root.device.disconnect();
            else
                root.device.connect();
        }

        onForgetTriggered: {
            deviceHeader.isExpanded = false;
            root.device.forget();
        }
    }

    Loader {
        id: deviceInfoLoader
        active: deviceHeader.isPaired
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: deviceHeader.bottom
        anchors.topMargin: Style.spacing.large
        opacity: deviceHeader.isExpanded ? 1 : 0
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation {
                duration: Style.animation.slow
                easing.type: Easing.InOutCubic
            }
        }

        sourceComponent: DeviceInfo {
            device: root.device
        }
    }
}
