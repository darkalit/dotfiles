pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property bool showTray: false
    property bool showPanel: false
    property bool showCalendar: false
    property bool doBrightnessCtl: false
    property bool showNotifications: false
    property bool showMixer: true

    function hideAll() {
        showTray = false;
        showPanel = false;
        showCalendar = false;
    }

    function toggleTray() {
        showTray = !showTray;
    }

    function togglePanel() {
        showPanel = !showPanel;
        doBrightnessCtl = !doBrightnessCtl;
    }

    function toggleCalendar() {
        showCalendar = !showCalendar;
    }

    function doShowMixer() {
        showMixer = true;
        showNotifications = false;
    }

    function doShowNotifications() {
        showMixer = false;
        showNotifications = true;
    }
}
