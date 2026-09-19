pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.components

Rectangle {
    id: root

    required property color fgColor
    required property color bgColor
    required property url iconSource
    required property real value

    color: bgColor
    radius: Style.radius.small

    RowLayout {
        anchors.fill: parent
        anchors.margins: Style.spacing.small

        ColorizedIcon {
            Layout.alignment: Qt.AlignVCenter

            iconSource: root.iconSource
            iconColor: root.fgColor
            implicitSize: 20
        }

        Text {
            Layout.alignment: Qt.AlignVCenter

            text: `${Math.round(root.value * 100)} %`
            color: root.fgColor
            font.pointSize: 10
        }
    }
}
