import QtQuick

Item {
    id: root
    required property int currentIndex
    required property int containerWidth
    required property int popupWidth
    required property Component networkContent
    required property Component bluetoothContent

    readonly property int margins: 100

    implicitWidth: root.containerWidth
    implicitHeight: root.currentIndex === 0 ? networkPopupContainer.height : bluetoothPopupContainer.height
    x: -root.currentIndex * root.popupWidth

    Behavior on x {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutCubic
        }
    }

    Rectangle {
        id: networkPopupContainer
        height: networkLoader.implicitHeight
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
        height: bluetoothLoader.implicitHeight
        width: root.containerWidth - root.margins
        x: root.popupWidth + root.margins / 2
        color: "transparent"

        Loader {
            id: bluetoothLoader
            sourceComponent: root.bluetoothContent
            anchors.fill: parent
        }
    }
}
