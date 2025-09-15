pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string time: {
        Qt.formatDateTime(clock.date, "ddd hh:mm:ss AP t d/M/yyyy");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
