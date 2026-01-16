import "../../../common"
import "../../../services"

import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    spacing: 30
    property int gaugeSize: 80

    CRadialGauge {
        value: CPU.cpuUsage / 100
        label: CPU.cpuUsage + "%"
        subLabel: "CPU"

        thickness: Appearance.resourceGaugeThickness

        width: root.gaugeSize
        height: root.gaugeSize
    }

    CRadialGauge {
        value: GPU.gpuUsage / 100
        label: GPU.gpuUsage + "%"
        subLabel: "GPU"

        thickness: Appearance.resourceGaugeThickness

        width: root.gaugeSize
        height: root.gaugeSize
    }

    CRadialGauge {
        value: RAM.ramUsage / 100
        label: RAM.ramUsage + "%"
        subLabel: "RAM"

        thickness: Appearance.resourceGaugeThickness

        width: root.gaugeSize
        height: root.gaugeSize
    }
}
