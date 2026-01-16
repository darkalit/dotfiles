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

    Rectangle {
        anchors.fill: parent
        radius: Appearance.componentRadius
        color: Colors.accent
        anchors.margins: 2
        opacity: ma.containsMouse ? 0.1 : 0.2
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            Notifications.dismissAll();
        }
    }

    Text {
        anchors.fill: parent
        anchors.centerIn: parent
        text: "󰩹"
        color: Colors.fg

        font.pixelSize: 20
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
