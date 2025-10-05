import Quickshell.Widgets
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs
import qs.components
import qs.components.battery

Rectangle {
    id: root
    required property var backdrop
    readonly property bool hasPopup: system.isExpanded || utils.isHovered || media.isHovered
    readonly property int margins: 10

    anchors.leftMargin: margins
    anchors.rightMargin: margins
    color: "transparent"

    Battery {
        id: battery
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        z: 1
    }

    WrapperMouseArea {
        id: popupMouseArea
        anchors.bottom: system.top
        width: popup.implicitWidth
        height: popup.implicitHeight

        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            implicitWidth: popup.implicitWidth
            implicitHeight: popup.implicitHeight
            color: "transparent"

            SystemPopup {
                id: popup
                isExpanded: system.isExpanded

                Behavior on implicitHeight {
                    NumberAnimation {
                        duration: 400
                        easing.type: Easing.InOutBack
                    }
                }
            }
        }
    }

    System {
        id: system
        backdrop: root.backdrop
        anchors.left: battery.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: root.margins
    }

    Media {
        id: media
        anchors.centerIn: parent
    }

    Utils {
        id: utils
        anchors.right: language.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: root.margins
    }

    Language {
        id: language
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }
}
