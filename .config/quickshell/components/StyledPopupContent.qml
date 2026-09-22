pragma ComponentBehavior: Bound

import QtQuick

import qs

Rectangle {
    property bool isExpanded

    radius: Style.radius.small
    clip: true
    color: Style.palette.base
}
