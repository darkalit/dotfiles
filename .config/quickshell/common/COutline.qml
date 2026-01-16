import "../services"

import QtQuick

Item {
    id: root
    anchors.fill: parent

    property bool canHover: false
    property int radius: Appearance.componentRadius

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        cursorShape: root.canHover ? Qt.PointingHandCursor : Qt.ArrowCursor
    }

    Rectangle {
        id: bg
        anchors.fill: parent
        anchors.margins: 2
        color: ma.containsMouse && root.canHover ? Colors.surface : "transparent"
        radius: root.radius
        border.width: 1
        border.color: Colors.borderFocus
        opacity: 0.4
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 3
        radius: root.radius - 1
        color: "transparent"
        border.width: 0.5
        border.color: Colors.border
        opacity: 0.2
    }
}
