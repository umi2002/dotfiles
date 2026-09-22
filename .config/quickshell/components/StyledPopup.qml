pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick

import qs
import qs.services

WrapperMouseArea {
    id: root
    required property bool isExpanded
    required property Component popupContent

    property int animationDuration: Style.animation.popup
    property Item target: null
    property real targetOffset: -1
    property int gravity: Edges.None
    property bool dismissable: false

    signal dismissed

    readonly property real targetPoint: !target ? 0 : targetOffset >= 0 ? target.x + targetOffset : gravity === Edges.Left ? target.x : gravity === Edges.Right ? target.x + target.width : target.x + target.width / 2

    hoverEnabled: true
    implicitWidth: loader.width
    implicitHeight: loader.height

    Component.onCompleted: PopupRegistry.register(root)
    Component.onDestruction: PopupRegistry.unregister(root)

    Binding {
        target: root
        property: "x"
        when: root.target !== null
        value: Math.max(0, Math.min(root.gravity === Edges.Left ? root.targetPoint : root.gravity === Edges.Right ? root.targetPoint - root.width : root.targetPoint - root.width / 2, root.parent.width - root.width))
    }

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
        property bool widthSettled: false
        clip: true

        onActiveChanged: {
            if (!active)
                widthSettled = true;
        }
        sourceComponent: root.popupContent

        onItemChanged: {
            if (item) {
                const content = item;
                loader.width = Qt.binding(() => content?.implicitWidth ?? 0);
                loader.height = Qt.binding(() => root.isExpanded && content ? content.implicitHeight : 0);
            }
        }

        Binding {
            target: loader.item
            property: "isExpanded"
            value: root.isExpanded
            when: loader.item !== null
        }

        Behavior on height {
            NumberAnimation {
                duration: root.animationDuration
                easing.type: Easing.Bezier
                easing.bezierCurve: Style.animation.curve
            }
        }

        Behavior on width {
            enabled: loader.widthSettled

            NumberAnimation {
                duration: root.animationDuration
                easing.type: Easing.Bezier
                easing.bezierCurve: Style.animation.curve
            }
        }

    }
}
