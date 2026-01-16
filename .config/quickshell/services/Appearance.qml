pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property real bgZoom: 0.005
    readonly property real bgSpeed: 0.1

    readonly property int windowGap: 16
    readonly property int sidebarWidth: 40
    readonly property int overlayRadius: 20
    readonly property int overlayOffset: 3
    readonly property int panelWidth: 400

    readonly property int trayIconSize: 20

    readonly property int componentOffset: 5
    readonly property int componentRadius: 8

    readonly property int resourceGaugeThickness: 10
}
