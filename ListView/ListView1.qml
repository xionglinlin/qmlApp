import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQml.Models

Rectangle {
    id: root

    property int spacingSize: 8
    property int buttonSize: 40

    color: "#e0e0e0"

    ListModel {
        id: ffmodel
        ListElement { name: "000" }
        ListElement { name: "111" }
        ListElement { name: "222" }
    }

    RowLayout {
        id: rowLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: root.spacingSize
        spacing: root.spacingSize
        height: buttonSize + 10

        Control {
            id: naviCol
            Layout.fillWidth: true
            Layout.fillHeight: true

            contentItem: ListView {
                id: naviView
                orientation: ListView.Horizontal
                boundsBehavior: Flickable.StopAtBounds //禁止列表首尾滑动
                spacing: 2
                clip: true
                model: ffmodel.count
                delegate: Rectangle {
                    width: height
                    height: naviView.height
                    opacity: (hoverHandler.hovered || mainView.currentIndex === index) ? 1 : 0.5
                    Text {
                        anchors.centerIn: parent
                        text: index
                    }
                    HoverHandler {
                        id: hoverHandler
                        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                        cursorShape: Qt.PointingHandCursor
                    }
                    TapHandler {
                        acceptedButtons: Qt.LeftButton
                        onTapped: {
                            mainView.currentIndex = index
                        }
                    }
                }
            }
        }

        Button {
            id: addBtn
            Layout.preferredWidth: buttonSize
            Layout.preferredHeight: buttonSize
            text: "+"
            onClicked: {
                let lastpage = ffmodel.count
                if (lastpage < 100) {
                    var data = { "name": "add" + lastpage};
                    ffmodel.append(data)
                    mainView.currentIndex = lastpage
                }
            }
        }

        Button {
            id: delBtn
            Layout.preferredWidth: buttonSize
            Layout.preferredHeight: buttonSize
            text: "-"
            onClicked: {
                let lastpage = ffmodel.count
                if (lastpage > 1)
                    ffmodel.remove(lastpage - 1)
            }
        }
    }

    ListView {
        id: mainView

        anchors.top: rowLayout.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        snapMode: ListView.SnapOneItem //将切换模式设置为单张切换
        orientation: ListView.Horizontal //将列表改成水平浏览模式
        highlightRangeMode: ListView.StrictlyEnforceRange //currentIndex跟随动态变化

        // 控制 listview 滚动速度，如果没有设置，listview滚动速度很慢
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 200
        highlightMoveVelocity: -1

        currentIndex: indicator.currentIndex

        model: ffmodel
        delegate: Rectangle {
            id: item
            width: mainView.width
            height: mainView.height
            color: index % 2 == 0 ? "red" : "green"

            Text {
                id: text
                anchors.centerIn: parent
                text: "name:" + name + " - " + "currentIndex:" + mainView.currentIndex
                font.bold: true
                font.pixelSize: 20
            }
        }
    }

    PageIndicator {
        id: indicator

        anchors.top: mainView.top
        anchors.topMargin: 10
        anchors.horizontalCenter: mainView.horizontalCenter
        count: ffmodel.count
        currentIndex: mainView.currentIndex
        interactive: true
        spacing: 10
        z: mainView.z + 1
        delegate: Rectangle {
            width: 10
            height: 10
            radius: width / 2
            color: Qt.rgba(0, 1, 1, index === indicator.currentIndex ? 0.9 : pressed ? 0.5 : 0.2)
        }
    }
}
