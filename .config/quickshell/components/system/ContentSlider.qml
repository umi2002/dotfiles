pragma ComponentBehavior: Bound

import QtQuick

import qs

Item {
    id: root
    required property int currentIndex
    required property int containerWidth
    required property int containerHeight
    required property int popupWidth
    required property Component networkContent
    required property Component bluetoothContent
    required property Component servicesContent

    readonly property int margins: 100
    readonly property var containers: [networkPopupContainer, bluetoothPopupContainer, servicesPopupContainer]

    implicitWidth: root.containerWidth
    implicitHeight: root.containers[root.currentIndex].height
    x: -root.currentIndex * root.popupWidth

    Behavior on x {
        NumberAnimation {
            duration: Style.animation.slow
            easing.type: Easing.InOutCubic
        }
    }

    Rectangle {
        id: networkPopupContainer
        height: Math.min(networkLoader.implicitHeight, root.containerHeight)
        implicitWidth: root.containerWidth - root.margins
        x: root.margins / 2
        color: "transparent"

        Loader {
            id: networkLoader
            sourceComponent: root.networkContent
            anchors.fill: parent
        }
    }

    Rectangle {
        id: bluetoothPopupContainer
        height: Math.min(bluetoothLoader.implicitHeight, root.containerHeight)
        width: root.containerWidth - root.margins
        x: root.popupWidth + root.margins / 2
        color: "transparent"

        Loader {
            id: bluetoothLoader
            sourceComponent: root.bluetoothContent
            anchors.fill: parent
        }
    }

    Rectangle {
        id: servicesPopupContainer
        height: Math.min(servicesLoader.implicitHeight, root.containerHeight)
        width: root.containerWidth - root.margins
        x: 2 * root.popupWidth + root.margins / 2
        color: "transparent"

        Loader {
            id: servicesLoader
            sourceComponent: root.servicesContent
            anchors.fill: parent
        }
    }
}
