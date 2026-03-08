pragma Singleton

import Quickshell
import Quickshell.Io
import QtQml

import qs

Singleton {
    id: root

    readonly property string time: Qt.formatDateTime(clock.date, "ddd hh:mm:ss AP t d/M/yyyy")

    property var events: []

    function eventsForDate(date) {
        const target = dateStr(date);
        return events.filter(e => e.dateStr === target);
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Process {
        id: fetchCalendar
        running: true
        command: ["curl", Secrets.calendar]
        stdout: StdioCollector {
            onStreamFinished: {
                root.events = root.parseIcs(this.text);
            }
        }
    }

    Timer {
        interval: 15 * 60 * 1000
        running: true
        repeat: true
        onTriggered: fetchCalendar.running = true
    }

    function parseIcs(text) {
        const unfolded = text.replace(/\r\n[ \t]/g, "").replace(/\n[ \t]/g, "");
        const lines = unfolded.split(/\r?\n/);

        const result = [];
        let cur = null;

        for (const line of lines) {
            if (line === "BEGIN:VEVENT") {
                cur = {};
            } else if (line === "END:VEVENT" && cur) {
                if (cur.summary && cur.dtstart) {
                    result.push(cur);
                }
                cur = null;
            } else if (cur) {
                const ci = line.indexOf(":");
                if (ci === -1)
                    continue;

                const keyFull = line.substring(0, ci);
                const val = line.substring(ci + 1);
                const key = keyFull.split(";")[0].toUpperCase();
                const params = keyFull.substring(key.length);

                switch (key) {
                case "SUMMARY":
                    cur.summary = unescape(val);
                    break;
                case "DESCRIPTION":
                    cur.description = unescape(val);
                    break;
                case "LOCATION":
                    cur.location = unescape(val);
                    break;
                case "DTSTART":
                    cur.allDay = params.includes("VALUE=DATE") || val.length === 8;
                    cur.dtstart = parseDate(val);
                    cur.dateStr = dateStr(cur.dtstart);
                    break;
                case "DTEND":
                    cur.dtend = parseDate(val);
                    break;
                }
            }
        }

        result.sort((a, b) => a.dtstart - b.dtstart);
        return result;
    }

    function parseDate(val) {
        if (val.length === 8) {
            return new Date(parseInt(val.substring(0, 4)), parseInt(val.substring(4, 6)) - 1, parseInt(val.substring(6, 8)));
        }
        const y = parseInt(val.substring(0, 4));
        const mo = parseInt(val.substring(4, 6)) - 1;
        const d = parseInt(val.substring(6, 8));
        const h = parseInt(val.substring(9, 11));
        const mi = parseInt(val.substring(11, 13));
        const s = parseInt(val.substring(13, 15));
        return val.endsWith("Z") ? new Date(Date.UTC(y, mo, d, h, mi, s)) : new Date(y, mo, d, h, mi, s);
    }

    function dateStr(date) {
        return date.getFullYear() + "-" + String(date.getMonth() + 1).padStart(2, "0") + "-" + String(date.getDate()).padStart(2, "0");
    }
}
