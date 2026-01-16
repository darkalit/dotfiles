import QtQuick
import QtQuick.Shapes

LinearGradient {
    id: root

    property color startColor1: "#000000"
    property color startColor2: "#1a0b2e"
    property color endColor1: "#0f0f1f"
    property color endColor2: "#000000"
    property int duration: 5000

    x1: 0
    y1: 100
    x2: 100
    y2: 0

    GradientStop {
        position: 0.0
        color: root.startColor1

        SequentialAnimation on color {
            loops: Animation.Infinite
            running: true
            ColorAnimation {
                to: root.startColor2
                duration: root.duration
            }
            ColorAnimation {
                to: root.startColor1
                duration: root.duration
            }
        }
    }

    GradientStop {
        position: 1.0
        color: root.endColor1

        SequentialAnimation on color {
            loops: Animation.Infinite
            running: true
            ColorAnimation {
                to: root.endColor2
                duration: 5000
            }
            ColorAnimation {
                to: root.endColor1
                duration: 5000
            }
        }
    }
}
