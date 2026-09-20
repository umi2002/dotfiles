pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick

QtObject {
    readonly property int batteryThreshold: 20
    readonly property int cavaBars: 20
    readonly property int nWorkspaces: 10

    readonly property int notificationHistoryLimit: 100
    readonly property int storageWriteDebounce: 1000

    readonly property int statsInterval: 1000
    readonly property int diskInterval: 30 * 1000
    readonly property int weatherInterval: 10 * 60 * 1000
    readonly property int weatherRetryInterval: 30 * 1000
    readonly property int calendarInterval: 15 * 60 * 1000
}
