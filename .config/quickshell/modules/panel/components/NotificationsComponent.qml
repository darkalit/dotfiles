pragma ComponentBehavior: Bound

import "../../../services"

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: "transparent"

    Rectangle {
        id: mask
        anchors.fill: parent
        radius: Appearance.componentRadius * 2 - 4
        visible: false
    }

    ScrollView {
        anchors.fill: parent
        clip: true
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }
        ColumnLayout {
            Layout.fillWidth: true

            Repeater {
                model: Notifications.list
                delegate: NotificationItem {
                    required property var modelData
                    notification: modelData
                }
            }
        }
    }
}
