import QtQuick

Item {
    id: root
    required property bool isExpanded
    required property Component popupContent
    property int topMargin: 0
    property int bottomMargin: 0
    property int leftMargin: 0
    property int rightMargin: 0

    property int animationDuration: 400
    property var animationEasing: Easing.InOutCubic

    implicitWidth: loader.width
    implicitHeight: loader.height

    Timer {
        id: deactivateTimer
        interval: root.animationDuration
        onTriggered: loader.active = false
    }

    onIsExpandedChanged: {
        if (isExpanded) {
            deactivateTimer.stop();
            loader.active = true;
        } else {
            deactivateTimer.restart();
        }
    }

    Loader {
        id: loader
        active: false
        clip: true
        sourceComponent: root.popupContent

        onItemChanged: {
            if (item) {
                item.isExpanded = Qt.binding(() => root.isExpanded);
                loader.width = Qt.binding(() => item.implicitWidth);
                loader.height = Qt.binding(() => root.isExpanded ? item.implicitHeight : 0);
            }
        }

        Behavior on height {
            NumberAnimation {
                duration: root.animationDuration
                easing.type: root.animationEasing
            }
        }

        Behavior on width {
            NumberAnimation {
                duration: root.animationDuration
                easing.type: root.animationEasing
            }
        }
    }
}
