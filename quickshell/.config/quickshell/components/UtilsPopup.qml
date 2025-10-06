import QtQuick
import QtQuick.Layouts

import qs
import qs.components
import qs.services

Rectangle {
    id: root
    property bool isExpanded
    readonly property int margins: 20

    implicitWidth: container.implicitWidth + margins
    implicitHeight: isExpanded ? container.implicitHeight + margins : 0

    color: "#bf" + Style.palette.background1.toString().substring(1)
    border.width: 1
    border.color: Style.palette.border1
    radius: 10
    clip: true

    Rectangle {
        id: container
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.margins / 2
        implicitWidth: layout.implicitWidth + root.margins
        implicitHeight: layout.implicitHeight + root.margins
        color: Style.palette.background2
        radius: 10

        ColumnLayout {
            id: layout
            anchors.centerIn: parent

            UtilsSlider {
                value: Brightness.brightnessPercent
                icon: Brightness.brightnessIcon
                setValueCallback: Brightness.setBrightness
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredHeight: 1
                color: Style.palette.color1
                opacity: 0.2
            }

            UtilsSlider {
                value: Audio.volume
                icon: Audio.volumeIcon
                setValueCallback: Audio.setVolume
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }
        }
    }
}
