// 主题风格类

pragma Singleton
import QtQuick

QtObject {

    readonly property int spacing_compact: 4
    readonly property int spacing_normal: 9

    readonly property int margins_compact: 4
    readonly property int margins_normal: 9

    readonly property int radius_small: 5
    readonly property int radius_normal: 10
    readonly property int radius_large: 20

    property color background_window: "#f0f0f0"
    property color background_navi: "#d7d8d8"
    property color color_active: "#0081ff"
    property color color_hover: Qt.rgba(0, 0, 0, 0.1)
}
