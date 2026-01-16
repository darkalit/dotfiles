pragma ComponentBehavior: Bound

import "components"
import "../../common"
import "../../services"
import "../../effects"

import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PanelWindow {
    id: root
    property bool show: States.showCalendar
    property vector2d offset: Qt.vector2d(Appearance.sidebarWidth + Appearance.windowGap, Appearance.windowGap)
    property date viewDate: new Date()
    property date today: new Date()

    visible: menuContainer.opacity > 0
    color: "transparent"

    function getDaysInMonth(date) {
        return new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate();
    }

    function getFirstDayOffset(date) {
        let day = new Date(date.getFullYear(), date.getMonth(), 1).getDay();
        return day === 0 ? 6 : day - 1;
    }

    function changeMonth(step) {
        viewDate = new Date(viewDate.getFullYear(), viewDate.getMonth() + step, 1);
    }

    function getDaysInPrevMonth(date) {
        return new Date(date.getFullYear(), date.getMonth(), 0).getDate();
    }

    MouseArea {
        anchors.fill: parent
        onClicked: States.showCalendar = false
        cursorShape: Qt.ArrowCursor
    }

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    Rectangle {
        id: menuContainer
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: Appearance.windowGap
        implicitWidth: 400
        implicitHeight: layout.implicitHeight
        color: "transparent"

        opacity: root.show ? 1.0 : 0.0
        scale: root.show ? 1.0 : 0.95

        Behavior on opacity {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutBack
            }
        }

        Rectangle {
            anchors.fill: parent
            radius: Appearance.componentRadius * 2
            opacity: menuContainer.opacity

            layer.enabled: true
            layer.samples: 2
            layer.effect: MistEffect {
                uResolution: Qt.vector2d(menuContainer.width, menuContainer.height)
                uOffset: root.offset
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
        }

        ColumnLayout {
            id: layout
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: Appearance.componentOffset
            spacing: Appearance.componentOffset

            RowLayout {
                Layout.topMargin: Appearance.componentOffset
                Layout.fillWidth: true

                Rectangle {
                    width: 32
                    height: 32
                    radius: 6
                    color: prevMA.containsMouse ? Colors.surface : "transparent"
                    Text {
                        text: "<"
                        anchors.centerIn: parent
                        color: Colors.fg
                        font.pixelSize: 14
                        font.bold: true
                    }
                    MouseArea {
                        id: prevMA
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: root.changeMonth(-1)
                    }
                }

                Text {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: root.viewDate.toLocaleDateString(Qt.locale(), "MMMM yyyy")
                    color: Colors.fg
                    font.bold: true
                    font.pixelSize: 18
                }

                Rectangle {
                    width: 32
                    height: 32
                    radius: 6
                    color: nextMA.containsMouse ? Colors.surface : "transparent"
                    Text {
                        text: ">"
                        anchors.centerIn: parent
                        color: Colors.fg
                        font.pixelSize: 14
                        font.bold: true
                    }
                    MouseArea {
                        id: nextMA
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: root.changeMonth(1)
                    }
                }
            }

            GridLayout {
                columns: 7
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.bottomMargin: Appearance.componentOffset
                columnSpacing: 4
                rowSpacing: 4
                Repeater {
                    model: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
                    delegate: Item {
                        required property var modelData
                        Layout.fillWidth: true
                        implicitHeight: 30

                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            text: parent.modelData
                            color: Colors.fgDim
                            font.pixelSize: 14
                        }
                    }
                }

                Repeater {
                    model: 42
                    delegate: Item {
                        required property int index

                        property int daysInCurrentMonth: root.getDaysInMonth(root.viewDate)
                        property int daysInPrevMonth: root.getDaysInPrevMonth(root.viewDate)
                        property int firstDayOffset: root.getFirstDayOffset(root.viewDate)
                        property int rawDay: index - firstDayOffset + 1
                        property bool isCurrentMonth: rawDay > 0 && rawDay <= daysInCurrentMonth
                        property bool isPrevMonth: rawDay <= 0
                        property bool isNextMonth: rawDay > daysInCurrentMonth
                        property bool isOtherMonth: isPrevMonth || isNextMonth
                        property bool isToday: isCurrentMonth && rawDay === root.today.getDate() && root.viewDate.getMonth() === root.today.getMonth() && root.viewDate.getFullYear() === root.today.getFullYear()
                        property int displayNum: {
                            if (isCurrentMonth)
                                return rawDay;
                            if (isPrevMonth)
                                return daysInPrevMonth + rawDay;
                            return rawDay - daysInCurrentMonth;
                        }

                        Layout.fillWidth: true
                        implicitHeight: 40

                        COutline {
                            anchors.fill: parent
                        }

                        Rectangle {
                            anchors.fill: parent
                            radius: Appearance.componentRadius
                            color: Colors.accent
                            anchors.margins: 2
                            opacity: (isToday ? 0.5 : 0.2) - (hoverHandler.hovered ? 0.1 : 0.0)
                        }

                        //color: isToday ? Colors.accent : (hoverHandler.hovered && isCurrentMonth ? Colors.surface : "transparent")
                        //border.width: isToday ? 0 : 1
                        //border.color: "transparent"

                        Text {
                            anchors.centerIn: parent
                            text: parent.displayNum

                            color: parent.isToday ? "#ffffff" : (parent.isCurrentMonth ? Colors.fg : Colors.fgDim)

                            font.bold: parent.isToday
                            font.pixelSize: 16

                            opacity: parent.isOtherMonth ? 0.5 : 1.0
                        }

                        HoverHandler {
                            id: hoverHandler
                        }
                    }
                }
            }
        }
    }
}
