import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland

import "modules/bar"
import "modules/screenoverlay"
import "modules/tray"
import "modules/panel"
import "modules/reload_popup"
import "modules/notification_popup"
import "modules/calendar"

ShellRoot {
    ReloadPopup {}

    Bar {}
    ScreenOverlay {}

    TrayMenu {}
    Panel {}
    NotificationPopup {}
    Calendar {}
}
