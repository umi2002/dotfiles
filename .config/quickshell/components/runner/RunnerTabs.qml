pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Item {
    id: root

    required property int selectedIndex

    implicitHeight: buttonRow.implicitHeight

    RowLayout {
        id: buttonRow
        anchors.fill: parent
        spacing: Style.spacing.large

        Repeater {
            id: repeater
            model: AppSearch.tabs

            WrapperMouseArea {
                id: tabButton

                required property int index
                required property string modelData

                hoverEnabled: true
                onClicked: RunnerState.tab = tabButton.index

                Text {
                    text: tabButton.modelData
                    color: root.selectedIndex === tabButton.index ? Style.palette.text : Style.palette.overlay1
                    font.family: Style.font.family1
                    font.pixelSize: 14

                    Behavior on color {
                        ColorAnimation {
                            duration: Style.animation.fast
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }

    Rectangle {
        anchors.top: parent.bottom
        anchors.topMargin: Style.spacing.small
        implicitHeight: 4
        implicitWidth: repeater.itemAt(root.selectedIndex)?.implicitWidth ?? 0
        radius: implicitHeight / 2
        color: Style.palette.green
        x: repeater.itemAt(root.selectedIndex)?.x ?? 0

        Behavior on x {
            NumberAnimation {
                duration: Style.animation.normal
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on implicitWidth {
            NumberAnimation {
                duration: Style.animation.normal
                easing.type: Easing.InOutQuad
            }
        }
    }
}
