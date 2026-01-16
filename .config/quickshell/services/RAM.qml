pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int ramUsage: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                let p = data.trim().split(/\s+/);
                let total = parseInt(p[1]) || 1;
                let used = parseInt(p[2]) || 0;
                root.ramUsage = Math.round(100 * used / total);
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: cpuProc.running = true
    }
}
