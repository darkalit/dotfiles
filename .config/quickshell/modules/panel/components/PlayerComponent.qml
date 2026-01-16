import "../../../common"
import "../../../services"

import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: root
    Layout.fillWidth: true
    Layout.preferredHeight: rootLayout.implicitHeight
    implicitHeight: rootLayout.implicitHeight
    //implicitHeight: 120

    readonly property MprisPlayer activePlayer: Mpris.players.values[0]

    function formatTime(seconds: real): string {
        const h = Math.floor(seconds / 3600);
        const m = Math.floor((seconds % 3600) / 60);
        const s = Math.round(seconds % 60);
        const t = [h, m > 9 ? m : h ? '0' + m : m || '0', s > 9 ? s : '0' + s].filter(Boolean).join(':');
        return seconds < 0 && seconds ? `-${t}` : t;
    }

    COutline {
        anchors.fill: parent
    }

    Rectangle {
        anchors.fill: parent
        radius: Appearance.componentRadius
        color: Colors.accent
        anchors.margins: 2
        opacity: 0.2
    }

    RowLayout {
        id: rootLayout
        anchors.fill: parent

        ClippingRectangle {
            Layout.leftMargin: Appearance.componentOffset * 2
            Layout.bottomMargin: Appearance.componentOffset * 2
            Layout.topMargin: Appearance.componentOffset * 2

            property real size: 120
            implicitWidth: size
            implicitHeight: size
            radius: Appearance.componentRadius

            Image {
                anchors.fill: parent
                anchors.centerIn: parent
                visible: source
                //sourceSize.width: size
                //sourceSize.height: size
                source: root.activePlayer.trackArtUrl || ""
                fillMode: Image.PreserveAspectCrop
                cache: true
            }
        }

        ColumnLayout {
            Layout.rightMargin: Appearance.componentOffset * 2
            Layout.bottomMargin: Appearance.componentOffset * 2
            Layout.topMargin: Appearance.componentOffset * 2
            spacing: 0

            Text {
                Layout.fillWidth: true
                text: root.activePlayer.trackTitle || "No title"
                color: Colors.fg

                maximumLineCount: 1
                elide: Text.ElideRight
                font.pixelSize: 16
                font.bold: true
            }

            Text {
                Layout.fillWidth: true
                text: root.activePlayer.trackArtist || "No artist"
                color: Colors.fgDim

                maximumLineCount: 1
                elide: Text.ElideRight
                font.pixelSize: 14
                font.bold: true
            }

            Item {
                implicitHeight: 5
            }

            RowLayout {
                Item {
                    implicitWidth: 34
                    implicitHeight: 34

                    Rectangle {
                        anchors.fill: parent
                        color: prevMA.containsMouse ? Colors.bg : Colors.surface
                        radius: 5
                    }

                    Text {
                        anchors.fill: parent
                        anchors.centerIn: parent
                        text: "󰒮"
                        color: Colors.fg

                        font.pixelSize: 20
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: prevMA
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            root.activePlayer.previous();
                        }
                    }
                }

                Item {
                    implicitWidth: 34
                    implicitHeight: 34

                    Rectangle {
                        anchors.fill: parent
                        color: pauseMA.containsMouse ? Colors.bg : Colors.surface
                        radius: 5
                    }

                    Text {
                        anchors.fill: parent
                        anchors.centerIn: parent
                        text: root.activePlayer.isPlaying ? "󰏤" : "󰐊"
                        color: Colors.fg

                        font.pixelSize: 20
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: pauseMA
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            root.activePlayer.togglePlaying();
                        }
                    }
                }

                Item {
                    implicitWidth: 34
                    implicitHeight: 34

                    Rectangle {
                        anchors.fill: parent
                        color: nextMA.containsMouse ? Colors.bg : Colors.surface
                        radius: 5
                    }

                    Text {
                        anchors.fill: parent
                        anchors.centerIn: parent
                        text: "󰒭"
                        color: Colors.fg

                        font.pixelSize: 20
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: nextMA
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            root.activePlayer.next();
                        }
                    }
                }
            }

            Item {
                implicitHeight: 5
            }

            RowLayout {
                Text {
                    text: root.formatTime(root.activePlayer.position)
                    color: Colors.fg

                    font.pixelSize: 16
                    font.bold: true
                    font.features: {
                        "tnum": 1
                    }
                }

                CSlider {
                    Layout.fillWidth: true
                    thickness: 10

                    value: root.activePlayer.position / root.activePlayer.length
                    onMoved: {
                        root.activePlayer.position = this.value * root.activePlayer.length;
                    }
                }

                Text {
                    text: root.formatTime(root.activePlayer.length)
                    color: Colors.fg

                    font.pixelSize: 16
                    font.bold: true
                    font.features: {
                        "tnum": 1
                    }
                }
            }
        }
    }

    FrameAnimation {
        running: root.activePlayer.playbackState == MprisPlaybackState.Playing
        onTriggered: root.activePlayer.positionChanged()
    }
}
