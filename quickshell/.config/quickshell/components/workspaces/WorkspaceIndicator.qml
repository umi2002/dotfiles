pragma ComponentBehavior: Bound

import QtQuick

import qs

Rectangle {
    id: indicator

    property int activeIndex: 0
    property real itemWidth: 30
    property real itemSpacing: 5
    property real layoutX: 0

    width: itemWidth
    height: itemWidth
    radius: width / 2
    color: Style.palette.color1

    x: layoutX + activeIndex * (itemWidth + itemSpacing)

    Behavior on x {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutCubic
        }
    }
}
