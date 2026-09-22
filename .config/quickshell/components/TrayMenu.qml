pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.components

StyledPopupContent {
    id: root

    property var menuHandle: null
    property var expandedEntry: null

    signal entryTriggered

    readonly property int margins: Style.spacing.normal

    implicitWidth: Math.max(180, layout.implicitWidth + margins * 2)
    implicitHeight: layout.implicitHeight + margins * 2


    onMenuHandleChanged: expandedEntry = null

    QsMenuOpener {
        id: opener
        menu: root.menuHandle
    }

    ColumnLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 0

        Repeater {
            model: opener.children

            delegate: ColumnLayout {
                id: entryColumn

                required property var modelData

                Layout.fillWidth: true
                spacing: 0

                Separator {
                    visible: entryColumn.modelData?.isSeparator ?? false
                    margin: Style.spacing.small
                }

                TrayMenuEntry {
                    visible: !(entryColumn.modelData?.isSeparator ?? false)
                    entry: entryColumn.modelData
                    submenuOpen: root.expandedEntry === entryColumn.modelData
                    Layout.fillWidth: true

                    onActivated: {
                        if (entryColumn.modelData?.hasChildren) {
                            root.expandedEntry = root.expandedEntry === entryColumn.modelData ? null : entryColumn.modelData;
                            return;
                        }
                        entryColumn.modelData?.triggered();
                        root.entryTriggered();
                    }
                }

                Loader {
                    active: (entryColumn.modelData?.hasChildren ?? false) && root.expandedEntry === entryColumn.modelData
                    visible: active
                    Layout.fillWidth: true

                    sourceComponent: ColumnLayout {
                        spacing: 0

                        QsMenuOpener {
                            id: submenuOpener
                            menu: entryColumn.modelData
                        }

                        Repeater {
                            model: submenuOpener.children

                            delegate: TrayMenuEntry {
                                required property var modelData

                                entry: modelData
                                indent: Style.spacing.large
                                Layout.fillWidth: true

                                onActivated: {
                                    modelData?.triggered();
                                    root.entryTriggered();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
