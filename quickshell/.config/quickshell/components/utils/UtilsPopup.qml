import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root

    property bool isExpanded
    readonly property int margins: 20
    readonly property int borderRadius: 10

    implicitWidth: container.implicitWidth + margins
    implicitHeight: isExpanded ? container.implicitHeight + margins : 0

    color: "#bf" + Style.palette.background1.toString().substring(1)
    border.width: 1
    border.color: Style.palette.border1
    radius: borderRadius
    clip: true

    Rectangle {
        id: container
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.margins / 2
        implicitWidth: layout.implicitWidth + root.margins
        implicitHeight: layout.implicitHeight + root.margins
        color: Style.palette.background2
        radius: root.borderRadius

        ColumnLayout {
            id: layout
            anchors.centerIn: parent

            UtilsSlider {
                value: Brightness.brightnessPercent
                icon: Brightness.brightnessIcon
                setValueCallback: Brightness.setBrightness
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }

            UtilsPopupSeparator {}

            UtilsSlider {
                value: Audio.volume
                icon: Audio.volumeIcon
                setValueCallback: Audio.setVolume
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }
        }
    }
}
