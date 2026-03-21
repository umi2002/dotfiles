import Quickshell.Widgets
import QtQuick

ClippingRectangle {
    id: root
    property alias imageSource: image.source

    anchors.fill: parent
    radius: Infinity
    clip: true
    color: "transparent"

    Image {
        id: image
        anchors.fill: parent
        sourceSize.width: root.implicitWidth * 2
        sourceSize.height: root.implicitHeight * 2
        smooth: true
        antialiasing: true
        fillMode: Image.PreserveAspectCrop
    }
}
