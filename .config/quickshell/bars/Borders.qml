pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects

import qs
import qs.services
import qs.components.notifications

PanelWindow {
    id: root
    focusable: true

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    color: "transparent"

    property var maskRegions: []

    function ownsPopup(popup) {
        for (let item = popup; item; item = item.parent)
            if (item === barsContainer)
                return true;
        return false;
    }

    function rebuildMaskRegions() {
        for (const region of maskRegions)
            region.destroy();

        const regions = PopupRegistry.popups.filter(popup => root.ownsPopup(popup)).map(popup => popupRegion.createObject(root, {
            item: popup
        }));
        regions.push(popupRegion.createObject(root, {
            item: Qt.binding(() => notifPopup.isVisible ? notifPopup : null)
        }));
        maskRegions = regions;
    }

    Component {
        id: popupRegion

        Region {
            intersection: Intersection.Subtract
        }
    }

    Connections {
        target: PopupRegistry

        function onPopupsChanged() {
            Qt.callLater(root.rebuildMaskRegions);
        }
    }

    Component.onCompleted: Qt.callLater(rebuildMaskRegions)

    mask: Region {
        item: frameHole
        radius: frameHole.radius
        intersection: Intersection.Subtract
        regions: root.maskRegions
    }

    readonly property var dismissablePopups: PopupRegistry.popups.filter(popup => popup.dismissable && popup.isExpanded && root.ownsPopup(popup))


    HyprlandFocusGrab {
        active: root.dismissablePopups.length > 0
        windows: [root]
        onCleared: {
            for (const popup of root.dismissablePopups)
                popup.dismissed();
        }
    }

    NotificationPopup {
        id: notifPopup
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 100
        anchors.rightMargin: 40
    }

    Item {
        id: barsContainer

        anchors.fill: parent
        layer.enabled: true

        TopBar {
            id: topBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: 50
            z: 1
            showRunner: screen.name === RunnerState.targetScreen
        }

        BottomBar {
            id: bottomBar
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: 50
            z: 1
        }

        Rectangle {
            anchors.fill: parent
            color: Style.palette.base

            layer.enabled: true
            layer.effect: MultiEffect {
                maskSource: mask
                maskEnabled: true
                maskInverted: true
            }
        }

        Item {
            id: mask

            anchors.fill: parent
            layer.enabled: true
            visible: false

            Rectangle {
                id: frameHole
                anchors.fill: parent
                anchors.margins: Style.spacing.normal
                anchors.topMargin: topBar.implicitHeight
                anchors.bottomMargin: bottomBar.implicitHeight
                radius: Style.radius.large
            }
        }
    }
}
