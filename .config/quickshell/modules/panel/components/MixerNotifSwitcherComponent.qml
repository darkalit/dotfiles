import "../../../services"
import "../../../common"

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    Layout.fillWidth: true
    Layout.preferredHeight: 42

    COutline {
        anchors.fill: parent
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                anchors.fill: parent
                radius: Appearance.componentRadius
                topRightRadius: 0
                bottomRightRadius: 0
                color: Colors.accent
                anchors.margins: 2
                anchors.rightMargin: 0
                opacity: (States.showNotifications ? 0.5 : 0.2) - (notifMA.containsMouse ? 0.1 : 0.0)
            }

            MouseArea {
                id: notifMA
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    States.doShowNotifications();
                }
            }

            Text {
                anchors.fill: parent
                anchors.centerIn: parent
                text: Notifications.list.length > 0 ? "󱅫" : "󰂚"
                color: Colors.fg

                font.pixelSize: 20
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                anchors.fill: parent
                radius: Appearance.componentRadius
                topLeftRadius: 0
                bottomLeftRadius: 0
                color: Colors.accent
                anchors.margins: 2
                anchors.leftMargin: 0
                opacity: (States.showMixer ? 0.5 : 0.2) - (mixerMA.containsMouse ? 0.1 : 0.0)
            }

            MouseArea {
                id: mixerMA
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    States.doShowMixer();
                }
            }

            Text {
                anchors.fill: parent
                anchors.centerIn: parent
                text: ""
                color: Colors.fg

                font.pixelSize: 20
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
