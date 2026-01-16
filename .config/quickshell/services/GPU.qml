pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int gpuUsage: 0

    Process {
        id: gpuProc
        command: ["cat", "/sys/class/drm/card1/device/gpu_busy_percent"]
        stdout: SplitParser {
            onRead: data => root.gpuUsage = parseInt(data.trim())
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: gpuProc.running = true
    }
}
