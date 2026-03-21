pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

WrapperMouseArea {
    id: root

    required property var modelData
    required property int index

    hoverEnabled: true

    onClicked: {
        AppSearch.launch(root.modelData);
        RunnerState.visible = false;
    }

    RowLayout {
        anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 10
        }
        spacing: 10

        IconImage {
            source: Quickshell.iconPath(root.modelData?.entry?.icon ?? "", "application-x-executable")
            implicitSize: 30
            Layout.alignment: Qt.AlignVCenter
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            Text {
                text: root.modelData?.name ?? ""
                color: Style.palette.text
                font.family: Style.font.family1
                font.pixelSize: 14
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            Text {
                text: root.modelData?.comment ?? root.modelData?.genericName ?? ""
                color: Style.palette.subtext0
                font.family: Style.font.family1
                font.pixelSize: 12
                elide: Text.ElideRight
                Layout.fillWidth: true
                visible: text.length > 0
            }
        }
    }
}
