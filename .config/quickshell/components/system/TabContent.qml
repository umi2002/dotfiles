pragma ComponentBehavior: Bound

import QtQuick

import qs

Item {
    id: root

    required property int currentIndex
    required property int containerWidth
    required property int containerHeight
    required property Component networkContent
    required property Component bluetoothContent
    required property Component servicesContent

    readonly property var contents: [root.networkContent, root.bluetoothContent, root.servicesContent]
    readonly property int margins: 100

    property int shownIndex: 0
    property bool ready: false

    implicitWidth: root.containerWidth
    implicitHeight: root.containerHeight

    Component.onCompleted: {
        root.shownIndex = root.currentIndex;
        root.ready = true;
    }

    onCurrentIndexChanged: {
        if (!root.ready) {
            root.shownIndex = root.currentIndex;
            return;
        }
        if (root.currentIndex === root.shownIndex)
            return;
        fadeIn.stop();
        fadeOut.restart();
    }

    NumberAnimation {
        id: fadeOut

        target: loader
        property: "opacity"
        to: 0
        duration: Style.animation.fast
        easing.type: Easing.InOutCubic

        onFinished: {
            root.shownIndex = root.currentIndex;
            fadeIn.restart();
        }
    }

    NumberAnimation {
        id: fadeIn

        target: loader
        property: "opacity"
        to: 1
        duration: Style.animation.normal
        easing.type: Easing.InOutCubic
    }

    Loader {
        id: loader

        x: root.margins / 2
        width: root.containerWidth - root.margins
        height: root.containerHeight
        sourceComponent: root.contents[root.shownIndex]
    }
}
