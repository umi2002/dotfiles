import Quickshell.Widgets
import QtQuick

import qs

Row {
    id: root
    spacing: 10

    property string selectedUser: ""
    property var userList: []

    signal prevUser()
    signal nextUser()

    WrapperMouseArea {
        onClicked: root.prevUser()

        Text {
            text: "◀"
            visible: root.userList.length > 1
            font.family: Style.font.family4
            font.pointSize: Style.font.size1
            color: Style.palette.subtext0
        }
    }

    Text {
        text: root.selectedUser || "..."
        font.family: Style.font.family4
        font.pointSize: Style.font.size1
        color: Style.palette.subtext0
    }

    WrapperMouseArea {
        onClicked: root.nextUser()

        Text {
            text: "▶"
            visible: root.userList.length > 1
            font.family: Style.font.family4
            font.pointSize: Style.font.size1
            color: Style.palette.subtext0
        }
    }
}
