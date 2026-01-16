import "../services"

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Slider {
    id: root
    property real thickness: 10

    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitHeight: root.thickness
        width: root.availableWidth
        height: implicitHeight
        radius: Appearance.componentRadius
        color: Colors.surface

        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            bottomLeftRadius: Appearance.componentRadius
            topLeftRadius: Appearance.componentRadius
            color: Colors.accent
        }
    }

    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 4
        implicitHeight: root.thickness + 10
        radius: 13
        color: Colors.fg
    }
}
