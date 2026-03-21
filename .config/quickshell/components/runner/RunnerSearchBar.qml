pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root

    required property var appList
    required property var scriptModel

    implicitHeight: 50
    radius: 10
    color: Style.palette.surface0

    readonly property alias text: searchField.text

    function focusSearchField() {
        searchField.text = "";
        searchField.forceActiveFocus();
    }

    RowLayout {
        anchors {
            fill: parent
            leftMargin: 20
            rightMargin: 20
        }
        spacing: 10

        Text {
            text: "\uf002"
            color: Style.palette.overlay1
            font.family: Style.font.family2
            font.pixelSize: 14
            Layout.alignment: Qt.AlignVCenter
        }

        TextInput {
            id: searchField
            Layout.fillWidth: true
            color: Style.palette.text
            selectionColor: Style.palette.mauve
            selectedTextColor: Style.palette.base
            font.family: Style.font.family1
            font.pixelSize: 14
            verticalAlignment: TextInput.AlignVCenter
            clip: true

            onTextChanged: {
                root.scriptModel.values = AppSearch.search(text);
                root.appList.currentIndex = 0;
            }

            Text {
                anchors.fill: parent
                text: "Search applications..."
                color: Style.palette.overlay1
                font: parent.font
                verticalAlignment: Text.AlignVCenter
                visible: parent.text.length === 0
            }

            Keys.onEscapePressed: RunnerState.visible = false
            Keys.onDownPressed: root.appList.incrementCurrentIndex()
            Keys.onUpPressed: root.appList.decrementCurrentIndex()
            Keys.onPressed: event => {
                if (event.key === Qt.Key_J && (event.modifiers & Qt.ControlModifier)) {
                    root.appList.incrementCurrentIndex();
                    event.accepted = true;
                } else if (event.key === Qt.Key_K && (event.modifiers & Qt.ControlModifier)) {
                    root.appList.decrementCurrentIndex();
                    event.accepted = true;
                }
            }
            Keys.onReturnPressed: {
                const entry = root.scriptModel.values[root.appList.currentIndex];
                if (entry) {
                    AppSearch.launch(entry);
                    RunnerState.visible = false;
                }
            }
        }

        WrapperMouseArea {
            Layout.alignment: Qt.AlignVCenter
            onClicked: searchField.text = ""

            Text {
                text: "\uf00d"
                color: Style.palette.overlay1
                font.family: Style.font.family2
                font.pixelSize: 12
                visible: searchField.text.length > 0
            }
        }
    }
}
