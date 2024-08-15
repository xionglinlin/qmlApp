import QtQuick

Window {
    id: root
    width: 800
    height: 600
    visible: true
    title: qsTr("qmlApp")

    color: ThemeStyle.background_window

    CatalogNavi {
        id: catalogNavi
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 150

        onClickItem: (sourceDate) => {
            console.log("load:", sourceDate)
            centerLoader.source = sourceDate
        }
    }

    Rectangle {
        id: centerRt
        anchors.left: catalogNavi.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: ThemeStyle.margins_normal
        radius: ThemeStyle.radius_normal
        clip: true

        Loader {
            id: centerLoader
            anchors.fill: parent
        }
    }
}
