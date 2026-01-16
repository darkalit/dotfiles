import "../../../services"

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    Layout.fillWidth: true
    height: text.implicitHeight + Appearance.componentOffset * 2

    Text {
        id: text
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text: ">"

        color: Colors.fg
        font.pixelSize: 16
        font.bold: true
        lineHeight: 1

        rotation: States.showTray ? 180 : 0

        Behavior on rotation {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutBack
                easing.overshoot: 2.0
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: States.toggleTray()
    }
}
