pragma ComponentBehavior: Bound

import "components"
import "../../services"

import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
    id: root

    anchors {
        top: true
        right: true
    }
    margins {
        top: Appearance.windowGap
        right: Appearance.windowGap
    }
    implicitWidth: 350
    implicitHeight: popupList.contentHeight
    /*
    Behavior on implicitHeight {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }
    */

    color: "transparent"

    ListView {
        id: popupList
        anchors.fill: parent
        spacing: Appearance.componentOffset

        model: Notifications.popupModel

        delegate: NotificationCardComponent {
            required property var modelData
            notification: modelData
            width: popupList.width
        }

        /*
        add: Transition {
            SequentialAnimation {
                NumberAnimation {
                    property: "x"
                    from: 350
                    to: 0
                    duration: 400
                    easing.type: Easing.OutBack
                }
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.OutInQuad
            }
            }
        }

        remove: Transition {
            SequentialAnimation {
                NumberAnimation {
                    property: "x"
                    to: 350
                    duration: 300
                    easing.type: Easing.InBack
                }
                NumberAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 200
                    easing.type: Easing.OutInQuad
                }
                NumberAnimation {
                    property: "height"
                    to: 0
                    duration: 300
                }
            }
        }

        displaced: Transition {
            NumberAnimation {
                property: "y"
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
        */
    }
}
