pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs

Rectangle {
    property int margin: Style.spacing.normal

    implicitHeight: 1
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignVCenter
    Layout.topMargin: margin
    Layout.bottomMargin: margin
    Layout.preferredHeight: 1
    color: Style.palette.subtext1
    opacity: 0.2
}
