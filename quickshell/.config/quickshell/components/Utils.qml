import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.components
import "../Style.js" as Style

Item {
    id: root
    property bool isHovered: popupMouseArea.containsMouse || utilsMouseArea.containsMouse
    implicitHeight: Math.max(popup.height, utils.height)
    implicitWidth: popup.width

    WrapperMouseArea {
        id: popupMouseArea
        hoverEnabled: true
        anchors.right: utilsMouseArea.right
        anchors.bottom: utilsMouseArea.top

        UtilsPopup {
            id: popup
            component: {
                if (brightnessMouseArea.containsMouse) {
                    return "brightness";
                } else if (audioMouseArea.containsMouse) {
                    return "audio";
                } else {
                    return component;
                }
            }

            implicitWidth: 350
            implicitHeight: root.isHovered ? 50 : 0
            clip: true

            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    WrapperMouseArea {
        id: utilsMouseArea
        hoverEnabled: true
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            id: utils
            implicitWidth: layout.width + 20
            implicitHeight: layout.height + 5
            radius: height / 2
            color: Style.palette.background2

            RowLayout {
                id: layout
                anchors.centerIn: parent

                WrapperMouseArea {
                    id: brightnessMouseArea
                    hoverEnabled: true
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: childrenRect.width
                    Layout.preferredHeight: childrenRect.height

                    Brightness {
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: 2
                    Layout.preferredHeight: parent.height - 5
                    Layout.leftMargin: 5
                    Layout.rightMargin: 5
                    color: Style.palette.color1
                }

                WrapperMouseArea {
                    id: audioMouseArea
                    hoverEnabled: true
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: childrenRect.width
                    Layout.preferredHeight: childrenRect.height

                    Audio {
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }
}
