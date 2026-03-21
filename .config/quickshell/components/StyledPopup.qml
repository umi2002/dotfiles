import Quickshell.Widgets
import QtQuick

WrapperMouseArea {
    id: root
    required property bool isExpanded
    required property Component popupContent

    property int animationDuration: 450

    hoverEnabled: true
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
                easing.type: Easing.Bezier
                easing.bezierCurve: [0.05, 0.7, 0.1, 1.0, 1.0, 1.0]
            }
        }

        Behavior on width {
            NumberAnimation {
                duration: root.animationDuration
                easing.type: Easing.Bezier
                easing.bezierCurve: [0.05, 0.7, 0.1, 1.0, 1.0, 1.0]
            }
        }

        Component.onCompleted: {
            // Some voodoo bs to fix animations when quickshell is first rendered
            active = true;
            active = false;
        }
    }
}
