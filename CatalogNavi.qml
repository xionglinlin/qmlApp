import QtQuick
import QtQuick.Controls
import QtQml.Models

Control {
    id: root

    property int itemHeight: 40

    signal clickItem(var sourceDate)

    background: Rectangle {
        color: ThemeStyle.background_navi
    }

    ListModel {
        id: naviModel
        ListElement { name: "Home"; source: "Home/MainPage.qml"; }
        ListElement { name: "ListView"; source: "ListView/MainPage.qml"; }
    }

    contentItem: ListView {
        id: listView
        boundsBehavior: Flickable.StopAtBounds // 禁止列表首尾回弹效果
        model: naviModel
        delegate: Rectangle {
            width: parent.width
            height: root.itemHeight
            color: ListView.isCurrentItem ? ThemeStyle.color_active : (firstItemHoverHandler.hovered ? ThemeStyle.color_hover : "transparent")

            Label {
                text: name
                anchors.centerIn: parent
            }

            HoverHandler {
                id: firstItemHoverHandler
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                cursorShape: Qt.PointingHandCursor
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    listView.currentIndex = index
                    root.clickItem(source)
                }
            }
        }

        Component.onCompleted: {
            listView.currentIndex = 0
            root.clickItem(naviModel.get(listView.currentIndex).source)
        }
    }
}
