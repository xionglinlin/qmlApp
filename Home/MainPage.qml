import QtQuick

Item {
    id: root

    Rectangle {
        id: backgroundRt
        anchors.fill: parent

        Text {
            id: hell
            anchors.centerIn: parent
            text: qsTr("Welecome to qmlApp")
            font.bold: true
            font.pixelSize: 25
        }
    }
}
