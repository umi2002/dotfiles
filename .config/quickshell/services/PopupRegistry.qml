pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell

Singleton {
    id: root

    property var popups: []

    function register(popup) {
        if (!popups.includes(popup))
            popups = popups.concat([popup]);
    }

    function unregister(popup) {
        popups = popups.filter(entry => entry !== popup);
    }
}
