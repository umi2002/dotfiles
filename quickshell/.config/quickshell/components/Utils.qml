import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.services as Services
import qs.components as Components
import "../Style.js" as Style

Item {
    id: root
    property bool isHovered: popupMouseArea.containsMouse || utilsMouseArea.containsMouse || brightnessMouseArea.containsMouse || audioMouseArea.containsMouse
    implicitHeight: Math.max(popup.height, utils.height)
    implicitWidth: popup.width

    UtilsPopup {
        id: popup
        value: {
            if (brightnessMouseArea.containsMouse) {
                return Services.Brightness.brightnessPercent / 100;
            } else if (audioMouseArea.containsMouse) {
                return Services.Audio.volume / 100;
            } else {
                return value;
            }
        }
        icon: {
            if (brightnessMouseArea.containsMouse) {
                return Services.Brightness.brightnessIcon;
            } else if (audioMouseArea.containsMouse) {
                return Services.Audio.volumeIcon;
            } else {
                return icon;
            }
        }

        anchors.right: utils.right
        anchors.bottom: utils.top
        implicitWidth: 350
        implicitHeight: root.isHovered ? 50 : 0
        clip: true

        Behavior on implicitHeight {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        MouseArea {
            id: popupMouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    Rectangle {
        id: utils
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: layout.width + 20
        implicitHeight: layout.height + 5
        radius: height / 2
        color: Style.palette.background2

        MouseArea {
            id: utilsMouseArea
            anchors.fill: parent
            hoverEnabled: true
        }

        RowLayout {
            id: layout
            anchors.centerIn: parent

            WrapperMouseArea {
                id: brightnessMouseArea
                hoverEnabled: true
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: childrenRect.width
                Layout.preferredHeight: childrenRect.height

                Components.Brightness {
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

                Components.Audio {
                    anchors.centerIn: parent
                }
            }
        }
    }
}
