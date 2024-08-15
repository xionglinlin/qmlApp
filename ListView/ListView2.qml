import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: root

    property bool refreshFlag: false

    Rectangle{
        width: parent.width
        height: -listView.contentY
        color: "cyan"
        Label{
            anchors.centerIn: parent
            text:"下拉刷新"
            visible: listView.contentY
        }
    }

    BusyIndicator{
        id:busy
        z:4
        running: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/3.
        Timer{
            interval: 2000
            running: busy.running
            onTriggered: {
                busy.running = false
            }
        }
    }

    ListView{
        id:listView
        anchors.fill: parent
        model: 30

        onContentYChanged: {
            if(-contentY > 40){
                refreshFlag = true
            }
        }
        onMovementEnded: {
            if(refreshFlag){
                refreshFlag = false
                busy.running = true
            }
        }

        onCurrentIndexChanged: {
            console.log("current index = ",currentIndex)
        }

        delegate: Rectangle{
              width: listView.width
              height: 70
              color: index%2 ? "red":"yellow"
              Label{
                  id:txt
                  anchors.centerIn: parent
                  font.pointSize: 20
                  text: index
              }
        }
    }
}
