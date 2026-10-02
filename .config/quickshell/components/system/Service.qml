pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.services

Rectangle {
    id: root

    required property var service
    required property bool isHovered

    clip: true
    implicitHeight: serviceHeader.implicitHeight + (serviceHeader.isExpanded ? serviceInfoLoader.implicitHeight + Style.spacing.large : 0)
    color: "transparent"

    Behavior on implicitHeight {
        NumberAnimation {
            duration: Style.animation.slow
            easing.type: Easing.InOutCubic
        }
    }

    ServiceHeader {
        id: serviceHeader

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        service: root.service
        isHovered: root.isHovered

        onActionTriggered: action => Systemd.control(root.service, action)
    }

    Loader {
        id: serviceInfoLoader

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: serviceHeader.bottom
        anchors.topMargin: Style.spacing.large
        opacity: serviceHeader.isExpanded ? 1 : 0
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation {
                duration: Style.animation.slow
                easing.type: Easing.InOutCubic
            }
        }

        sourceComponent: ServiceInfo {
            service: root.service
        }
    }
}
