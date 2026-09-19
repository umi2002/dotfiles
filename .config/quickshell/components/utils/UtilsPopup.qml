pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.components

import qs
import qs.assets
import qs.services

Rectangle {
    id: root

    property bool isExpanded
    readonly property int margins: Style.spacing.large
    readonly property int borderRadius: 10

    implicitWidth: container.implicitWidth + margins
    implicitHeight: container.implicitHeight + margins

    radius: borderRadius
    clip: true
    color: Style.palette.base

    Rectangle {
        id: container
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.margins / 2
        implicitWidth: layout.implicitWidth + root.margins
        implicitHeight: layout.implicitHeight + root.margins
        radius: root.borderRadius

        color: "transparent"

        ColumnLayout {
            id: layout
            anchors.centerIn: parent

            UtilsSlider {
                value: Brightness.brightness
                icon: Assets.brightness.getIcon(Brightness.brightness)
                setValueCallback: Brightness.setBrightness
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }

            Separator {
                margin: 0
            }

            UtilsSlider {
                value: Audio.volume
                icon: Assets.volume.getIcon(Audio.volume, Audio.muted)
                setValueCallback: Audio.setVolume
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }
        }
    }
}
