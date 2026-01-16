import "../../../services"

import QtQuick
import QtQuick.Layouts

MouseArea {
    implicitHeight: Appearance.sidebarWidth - (Appearance.overlayOffset * 2)
    implicitWidth: Appearance.sidebarWidth - (Appearance.overlayOffset * 2)

    Text {
        anchors.centerIn: parent
        text: "󰣇"
        color: Colors.accent
        font.pixelSize: 20
        font.bold: true
        lineHeight: 0.8
    }

    onClicked: States.togglePanel()
}
