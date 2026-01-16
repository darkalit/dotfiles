import "../services"

import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    default property alias content: contentItem.data

    Layout.fillWidth: true
    Layout.preferredHeight: contentItem.implicitHeight + 8

    implicitWidth: contentItem.implicitWidth
    implicitHeight: contentItem.implicitHeight + 8

    property int radius: 10
    color: "transparent"

    ColumnLayout {
        id: contentItem
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.centerIn: parent
        spacing: 10
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 2
        color: "transparent"
        radius: root.radius - 2
        border.width: 1
        border.color: Colors.accent
        opacity: 0.6
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 3
        radius: root.radius - 3
        color: "transparent"
        border.width: 0.5
        border.color: Colors.surface
        opacity: 0.2
    }

    /*
    Rectangle {
        id: glassBase
        implicitWidth: parent.width
        implicitHeight: parent.height
        anchors.centerIn: parent
        radius: root.radius
        color: Qt.rgba(0.95, 0.95, 1.0, 0.3)

        layer.enabled: true
        layer.effect: MultiEffect {
            blurEnabled: true
            blur: 1.0
            blurMax: 64
            blurMultiplier: 2.0
            saturation: -0.3
            brightness: -0.2
        }
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 2
        color: "transparent"
        radius: root.radius - 2
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 0.4)
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 3
        radius: root.radius - 3
        color: "transparent"
        border.width: 0.5
        border.color: Qt.rgba(1, 1, 1, 0.2)
    }

    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 3
        anchors.leftMargin: 3
        anchors.rightMargin: 3
        height: parent.height * 0.6
        radius: root.radius - 3
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Qt.rgba(1, 1, 1, 0.5)
            }
            GradientStop {
                position: 0.3
                color: Qt.rgba(1, 1, 1, 0.25)
            }
            GradientStop {
                position: 0.6
                color: Qt.rgba(1, 1, 1, 0.08)
            }
            GradientStop {
                position: 1.0
                color: "transparent"
            }
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 3
        height: parent.height * 0.25
        radius: root.radius - 3
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "transparent"
            }
            GradientStop {
                position: 0.5
                color: Qt.rgba(0, 0, 0, 0.1)
            }
            GradientStop {
                position: 1.0
                color: Qt.rgba(0, 0, 0, 0.2)
            }
        }
    }
    */
}
