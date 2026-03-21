pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root
    property bool isExpanded

    readonly property int itemHeight: 60
    readonly property int maxItems: 8

    implicitWidth: 600
    implicitHeight: column.implicitHeight + 20
    radius: 10
    clip: true
    color: Style.palette.base

    opacity: isExpanded ? 1.0 : 0.0
    transformOrigin: Item.Top

    Behavior on opacity {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    onIsExpandedChanged: {
        if (isExpanded) {
            searchBar.focusSearchField();
        }
    }

    ColumnLayout {
        id: column
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 10
        }
        spacing: 10

        RunnerSearchBar {
            id: searchBar
            Layout.fillWidth: true
            appList: appList
            scriptModel: scriptModel
        }

        ListView {
            id: appList
            Layout.fillWidth: true
            Layout.preferredHeight: Math.min(count * root.itemHeight, root.maxItems * root.itemHeight)
            visible: count > 0
            clip: true
            currentIndex: 0

            model: ScriptModel {
                id: scriptModel
                values: AppSearch.search("")
            }

            highlightFollowsCurrentItem: false
            highlight: Rectangle {
                radius: 10
                color: Style.palette.surface0
                width: appList.width
                height: root.itemHeight
                y: appList.currentItem?.y ?? 0

                Behavior on y {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutCubic
                    }
                }
            }

            add: Transition {
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            remove: Transition {
                NumberAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 150
                    easing.type: Easing.InCubic
                }
            }

            displaced: Transition {
                NumberAnimation {
                    property: "y"
                    duration: 200
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    property: "opacity"
                    to: 1
                }
            }

            delegate: RunnerEntry {
                implicitWidth: appList.width
                implicitHeight: 60

                onEntered: appList.currentIndex = index
            }
        }
    }
}
