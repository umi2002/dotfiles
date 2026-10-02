pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.assets
import qs.services

ColumnLayout {
    id: root

    spacing: 30

    Component.onCompleted: Systemd.refresh()

    RowLayout {
        Layout.fillWidth: true
        spacing: Style.spacing.normal

        Text {
            text: Systemd.failedCount === 0 ? "All services healthy" : Systemd.failedCount + (Systemd.failedCount === 1 ? " failed service" : " failed services")
            font.pointSize: Style.font.size1
            font.family: Style.font.family1
            color: Systemd.failedCount === 0 ? Style.palette.green : Style.palette.red
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        Item {
            Layout.fillWidth: true
        }

        ServiceActionButton {
            icon: Assets.services.restart
            iconColor: Style.palette.subtext0
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

            onActionTriggered: Systemd.refresh()
        }
    }

    ServicesSection {
        title: "User"
        servicesModel: Systemd.userUnits
    }

    ServicesSection {
        title: "System"
        servicesModel: Systemd.systemUnits
    }

    Item {
        Layout.fillHeight: true
    }
}
