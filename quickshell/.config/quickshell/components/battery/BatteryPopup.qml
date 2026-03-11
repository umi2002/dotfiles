pragma ComponentBehavior: Bound

import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

import qs
import qs.assets

Rectangle {
    id: root

    property bool isExpanded
    readonly property int margins: 20
    readonly property int profileItemWidth: 30
    readonly property int profileSpacing: 20
    readonly property int activeProfileIndex: {
        switch (PowerProfiles.profile) {
        case PowerProfile.Performance:
            return 0;
        case PowerProfile.PowerSaver:
            return 2;
        default:
            return 1;
        }
    }

    implicitWidth: layout.implicitWidth + margins
    implicitHeight: layout.implicitHeight + margins

    radius: 10
    clip: true
    color: Style.palette.base

    Rectangle {
        width: root.profileItemWidth
        height: root.profileItemWidth
        radius: width / 2
        color: Style.palette.green
        anchors.verticalCenter: parent.verticalCenter
        x: layout.x + root.activeProfileIndex * (root.profileItemWidth + root.profileSpacing)

        Behavior on x {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutCubic
            }
        }
    }

    RowLayout {
        id: layout

        anchors.centerIn: parent
        spacing: root.profileSpacing

        BatteryProfile {
            isSelected: PowerProfiles.profile === PowerProfile.Performance
            iconSource: Assets.battery.performance

            onClicked: {
                PowerProfiles.profile = PowerProfile.Performance;
            }
        }

        BatteryProfile {
            isSelected: PowerProfiles.profile === PowerProfile.Balanced
            iconSource: Assets.battery.balanced

            onClicked: {
                PowerProfiles.profile = PowerProfile.Balanced;
            }
        }

        BatteryProfile {
            isSelected: PowerProfiles.profile === PowerProfile.PowerSaver
            iconSource: Assets.battery.power_saver

            onClicked: {
                PowerProfiles.profile = PowerProfile.PowerSaver;
            }
        }
    }
}
