pragma Singleton

import Quickshell
import Quickshell.Services.SystemTray
import QtQml.Models

Singleton {
    readonly property list<SystemTrayItem> trayItems: SystemTray.items.values
    property var trayMap: {}
    property ListModel trayModel: ListModel {}

    function updateTrayMap() {
        let map = {};
        SystemTray.items.values.forEach(item => {
            map[item.id] = item;
        });
        trayMap = map;
    }

    function updateTrayModel() {
        let newIds = new Set(trayItems.map(item => item.id));
        let existingIds = new Set();

        for (let i = 0; i < trayModel.count; i++) {
            existingIds.add(trayModel.get(i).id);
        }

        for (let i = trayModel.count - 1; i >= 0; i--) {
            let itemId = trayModel.get(i).id;
            if (!newIds.has(itemId)) {
                trayModel.remove(i);
            }
        }

        for (let i = 0; i < trayItems.length; i++) {
            let newItem = trayItems[i];
            let found = false;
            let currentIndex = -1;

            for (let j = 0; j < trayModel.count; j++) {
                if (trayModel.get(j).id === newItem.id) {
                    found = true;
                    currentIndex = j;
                    break;
                }
            }

            if (found) {
                if (currentIndex !== i) {
                    trayModel.move(currentIndex, i, 1);
                }
            } else {
                trayModel.insert(i, {
                    id: newItem.id
                });
            }
        }
    }

    onTrayItemsChanged: {
        updateTrayMap();
        updateTrayModel();
    }
}
