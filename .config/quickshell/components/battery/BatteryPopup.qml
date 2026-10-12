pragma ComponentBehavior: Bound

import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

import qs
import qs.components
import qs.assets

StyledPopupContent {
    id: root

    readonly property int margins: Style.spacing.large
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


    Rectangle {
        id: indicator

        readonly property real slot: root.activeProfileIndex * (root.profileItemWidth + root.profileSpacing)

        property bool sliding: false
        property bool ready: false

        width: root.profileItemWidth
        height: root.profileItemWidth
        radius: width / 2
        color: Style.palette.green
        anchors.verticalCenter: parent.verticalCenter
        x: layout.x + indicator.slot


        Component.onCompleted: indicator.ready = true

        onSlotChanged: {
            if (!indicator.ready)
                return;
            indicator.sliding = true;
            settle.restart();
        }

        Timer {
            id: settle

            interval: Style.animation.normal + Style.animation.fast
            onTriggered: indicator.sliding = false
        }

        Behavior on x {
            enabled: indicator.sliding

            NumberAnimation {
                duration: Style.animation.normal
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
