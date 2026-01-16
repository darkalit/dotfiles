import "../../../services"
import "../../../common"

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: root
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignRight
    spacing: Appearance.componentOffset
    property bool expanded: false

    Item {
        id: menuContainer
        Layout.preferredHeight: 40
        Layout.alignment: Qt.AlignRight
        clip: true

        Layout.preferredWidth: root.expanded ? buttonsRow.implicitWidth : 0

        Behavior on Layout.preferredWidth {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }

        opacity: root.expanded ? 1.0 : 0.0
        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }

        RowLayout {
            id: buttonsRow
            anchors.right: parent.right
            height: parent.height
            spacing: 5

            PowerActionButton {
                icon: "󰌾"
                onClicked: Quickshell.execDetached(["hyprlock"])
            }

            PowerActionButton {
                icon: "󰗽"
                onClicked: Quickshell.execDetached(["sh", "-c", "loginctl terminate-user $USER"])
            }

            PowerActionButton {
                icon: "󰜉"
                onClicked: Quickshell.execDetached(["systemctl", "reboot"])
            }

            PowerActionButton {
                icon: "󰐥"
                onClicked: Quickshell.execDetached(["systemctl", "poweroff"])
            }
        }
    }

    Item {
        Layout.preferredWidth: 40
        Layout.preferredHeight: 40
        Layout.alignment: Qt.AlignRight

        COutline {
            anchors.fill: parent
        }

        Rectangle {
            anchors.fill: parent
            radius: Appearance.componentRadius
            color: Colors.accent
            anchors.margins: 2
            opacity: powerMenuMA.containsMouse ? 0.1 : 0.2
        }

        MouseArea {
            id: powerMenuMA
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                root.expanded = !root.expanded;
            }
        }

        Text {
            anchors.fill: parent
            anchors.centerIn: parent
            text: ""
            color: Colors.fg

            font.pixelSize: 24
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    component PowerActionButton: Item {
        id: btn
        Layout.preferredWidth: 40
        Layout.preferredHeight: 40

        property string icon: ""
        property color color: Colors.surface
        signal clicked

        COutline {
            anchors.fill: parent
        }

        Rectangle {
            anchors.fill: parent
            radius: Appearance.componentRadius
            color: btn.color
            anchors.margins: 2
            opacity: ma.containsMouse ? 0.3 : 0.1
        }

        MouseArea {
            id: ma
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                States.hideAll();
                root.expanded = false;
                btn.clicked();
            }
        }

        Text {
            anchors.centerIn: parent
            text: btn.icon
            color: Colors.fg
            font.pixelSize: 20
        }
    }
}
