pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

import qs.services

Singleton {
    id: root

    property bool ready: false
    property bool lastPlugged: false
    property bool lastLow: false
    property bool lastCritical: false

    function remaining() {
        const time = Battery.timeToEmpty;
        return Battery.batteryPercent + "% remaining" + (time === "" ? "" : " • " + time);
    }

    function send(summary, body, urgency, icon, sound) {
        notifier.command = ["notify-send", "-a", "Battery", "-u", urgency, "-i", icon, "-h", "string:sound-name:" + sound, summary, body];
        notifier.running = true;
    }

    function changed() {
        if (!root.ready)
            return;
        if (!cooldown.running)
            root.evaluate();
        cooldown.restart();
    }

    function snapshot() {
        root.lastPlugged = Battery.isPluggedIn;
        root.lastLow = Battery.isBatteryLow;
        root.lastCritical = Battery.isBatteryCritical;
    }

    function evaluate() {
        if (!root.ready)
            return;

        if (Battery.isPluggedIn !== root.lastPlugged) {
            if (Battery.isPluggedIn)
                root.send("Charger connected", Battery.statusText, "low", "battery-full-charging-symbolic", "power-plug");
            else
                root.send("Charger disconnected", root.remaining(), "low", "battery-good-symbolic", "power-unplug");
        } else if (Battery.isBatteryCritical && !root.lastCritical) {
            root.send("Battery critical", root.remaining(), "critical", "battery-caution-symbolic", "battery-caution");
        } else if (Battery.isBatteryLow && !root.lastLow && !Battery.isBatteryCritical) {
            root.send("Battery low", root.remaining(), "normal", "battery-low-symbolic", "battery-low");
        }

        root.snapshot();
    }

    Process {
        id: notifier
    }

    Timer {
        id: cooldown

        interval: 1100
        onTriggered: root.evaluate()
    }

    Timer {
        id: settle

        interval: 3000
        running: Battery.deviceReady
        onTriggered: {
            root.snapshot();
            root.ready = true;
        }
    }

    Connections {
        target: Battery

        function onIsPluggedInChanged() {
            root.changed();
        }

        function onIsBatteryLowChanged() {
            root.changed();
        }

        function onIsBatteryCriticalChanged() {
            root.changed();
        }
    }
}
