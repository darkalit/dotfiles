pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int percent: 0
    property bool isCharging: false

    Process {
        id: procCapacity
        command: ["cat", "/sys/class/power_supply/BAT1/capacity"]
        stdout: SplitParser {
            onRead: data => root.percent = parseInt(data.trim())
        }
        Component.onCompleted: running = true
    }

    Process {
        id: procStatus
        command: ["cat", "/sys/class/power_supply/BAT1/status"]
        stdout: SplitParser {
            onRead: data => root.isCharging = (data.trim() === "Charging" || data.trim() === "Full")
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            procCapacity.running = true;
            procStatus.running = true;
        }
    }
}
