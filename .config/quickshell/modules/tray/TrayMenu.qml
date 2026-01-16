import "../../services"
import "../../effects"

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

PanelWindow {
    id: root
    property int maxColumns: 4
    property int itemCount: SystemTray.items.values.length
    property int currentColumns: Math.min(itemCount, maxColumns)
    property vector2d offset: Qt.vector2d(Appearance.windowGap, 96)
    property bool show: States.showTray

    visible: menuContainer.opacity > 0
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        onClicked: States.showTray = false
        cursorShape: Qt.ArrowCursor
    }

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    Rectangle {
        id: menuContainer
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: root.offset.x
        anchors.bottomMargin: root.offset.y
        width: layout.implicitWidth + Appearance.componentOffset * 1.4
        height: layout.implicitHeight + Appearance.componentOffset * 1.4
        radius: Appearance.componentRadius
        color: "transparent"

        opacity: root.show ? 1.0 : 0.0
        scale: root.show ? 1.0 : 0.95

        Behavior on opacity {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutBack
                //overshoot: 2.0
            }
        }

        Rectangle {
            anchors.fill: parent
            radius: Appearance.componentRadius
            opacity: menuContainer.opacity

            layer.enabled: true
            layer.samples: 2
            layer.effect: MistEffect {
                uResolution: Qt.vector2d(menuContainer.width, menuContainer.height)
                uOffset: Qt.vector2d(root.offset.x + Appearance.sidebarWidth, root.offset.y)
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
        }

        Grid {
            id: layout
            anchors.centerIn: parent
            flow: Flow.LeftToRight

            columns: root.currentColumns

            rowSpacing: Appearance.componentOffset / 2
            columnSpacing: Appearance.componentOffset / 2

            Repeater {
                model: SystemTray.items
                TrayItem {}
            }
        }
    }
}
