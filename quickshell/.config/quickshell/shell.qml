import Quickshell
import Quickshell.Io

import qs.bars

ShellRoot {
    Variants {
        model: Quickshell.screens

        Borders {
            required property var modelData

            screen: modelData
        }
    }
}
