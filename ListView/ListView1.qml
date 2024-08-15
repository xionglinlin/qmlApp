import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: root

    ListView {
        id: listView
        anchors.fill: parent
        model: 10  //列表数量
        snapMode: ListView.SnapOneItem  //将切换模式设置为单张切换
        orientation: ListView.Horizontal  //将列表改成水平浏览模式
        highlightRangeMode: ListView.StrictlyEnforceRange  //currentIndex跟随动态变化
        boundsBehavior: Flickable.StopAtBounds //禁止列表首尾滑动

        delegate: Rectangle {
            width: listView.width
            height: listView.height
            color: index % 2 ? "red" : "blue"
            Label {
                id: numLabel
                anchors.centerIn: parent
                font.pointSize: 100
                text: index
            }
            Label {
                anchors {
                    horizontalCenter: numLabel.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: 10
                }
                font.pointSize: 20
                text: "currentIndex=" + listView.currentIndex
            }
        }
    }
}
