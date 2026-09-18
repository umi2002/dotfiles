pragma Singleton

import Quickshell
import Quickshell.Services.SystemTray

Singleton {
    readonly property ScriptModel trayModel: ScriptModel {
        values: SystemTray.items.values
    }
}
