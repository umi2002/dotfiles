pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

import qs
import qs.services

Rectangle {
    id: root
    readonly property ScriptModel trayItems: Tray.trayModel
    property SystemTrayItem menuItem: null
    property real menuCenter: 0

    function closeMenu() {
        menuItem = null;
    }

    implicitWidth: listView.implicitWidth
    color: "transparent"

    Behavior on implicitWidth {
        NumberAnimation {
            duration: Style.animation.normal
            easing.type: Easing.InOutCubic
        }
    }

    ListView {
        id: listView

        model: root.trayItems
        orientation: ListView.Horizontal
        spacing: Style.spacing.small
        implicitWidth: contentWidth
        implicitHeight: 20
        anchors.verticalCenter: parent.verticalCenter

        delegate: WrapperMouseArea {
            id: trayItem
            required property SystemTrayItem modelData
            readonly property SystemTrayItem item: modelData
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

            onClicked: event => {
                if (event.button === Qt.RightButton) {
                    if (!trayItem.item?.hasMenu)
                        return;
                    if (root.menuItem === trayItem.item) {
                        root.closeMenu();
                        return;
                    }
                    root.menuCenter = trayItem.mapToItem(root, trayItem.width / 2, 0).x;
                    root.menuItem = trayItem.item;
                    return;
                }

                if (event.button === Qt.MiddleButton) {
                    trayItem.item?.secondaryActivate();
                    return;
                }

                if (trayItem.item?.onlyMenu) {
                    if (trayItem.item?.hasMenu) {
                        root.menuCenter = trayItem.mapToItem(root, trayItem.width / 2, 0).x;
                        root.menuItem = trayItem.item;
                    }
                    return;
                }

                const itemName = (trayItem.item?.id ?? "").toLowerCase().split(/[^a-z0-9]+/)[0];
                const matchedClass = itemName ? HyprlandData.windowClasses.find(cls => cls.toLowerCase().split(/[^a-z0-9]+/).includes(itemName)) : undefined;

                if (matchedClass) {
                    HyprlandData.focusWindow(matchedClass);
                } else {
                    trayItem.item?.activate();
                }
            }

            IconImage {

                source: trayItem.item?.icon ?? ""
                implicitSize: 20
            }
        }

        add: Transition {
            NumberAnimation {
                properties: "opacity"
                from: 0
                to: 1
                duration: Style.animation.normal
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                properties: "scale"
                from: 0.5
                to: 1
                duration: Style.animation.normal
                easing.type: Easing.InOutCubic
            }
        }

        remove: Transition {
            NumberAnimation {
                properties: "opacity"
                from: 1
                to: 0
                duration: Style.animation.normal
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                properties: "scale"
                from: 1
                to: 0.5
                duration: Style.animation.normal
                easing.type: Easing.InOutCubic
            }
        }

        displaced: Transition {
            NumberAnimation {
                properties: "x"
                duration: Style.animation.normal
                easing.type: Easing.InOutCubic
            }
        }
    }
}
