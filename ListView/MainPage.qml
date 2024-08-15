import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    property int tabBarHeight: 40

    TabBar {
        id: tabbar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: root.tabBarHeight
        TabButton {
            text: qsTr("ListView1")
        }
        TabButton {
            text: qsTr("ListView2")
        }
        TabButton {
            text: qsTr("ListView2")
        }
    }

    StackLayout {
        anchors.top: tabbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        currentIndex: tabbar.currentIndex
        clip: true

        ListView1 {
            id: view1
        }
        ListView2 {
            id: view2
        }
        ListView3 {
            id: view3
        }
    }
}
