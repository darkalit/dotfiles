pragma Singleton

import Quickshell
import QtQuick

Singleton {
    property real time: 0

    NumberAnimation on time {
        from: 0
        to: 10000
        duration: 1000000
        loops: Animation.Infinite
    }
}
