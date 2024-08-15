import QtQuick 2.9
import QtQuick.Controls 2.0

//ListView导航页
ListView {
    id: control

    //在item初始化时填充
    //分组列表
    property var groupList: []
    //分组列表对应的一个item的index
    property var indexList: []

    //表头
    header: Rectangle{
        width: ListView.view.width
        height: 35
        color: "black"
        //标题
        Text {
            anchors.centerIn: parent
            text: "Item Count: "+control.count
            color: "white"
        }
    }

    //选项
    delegate: Rectangle{
        id: item
        width: ListView.view.width
        height: 35
        color: mousearea.containsMouse?"gray":"white"
        //底部横线
        Rectangle{
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: "black"
        }
        //左侧黑方块表示选中
        Rectangle{
            height: parent.height
            width: 10
            color: "black"
            visible: item.ListView.isCurrentItem
        }
        //文本内容
        Text {
            anchors.centerIn: parent
            text: name //对应model的name属性
        }
        MouseArea{
            id: mousearea
            hoverEnabled: true
            anchors.fill: parent
            onClicked: {
                control.currentIndex=index
            }
        }
        ToolTip.text: "ToolTip: "+group+"  "+name
        ToolTip.visible: mousearea.containsMouse
        //在构建时填充导航栏的model
        Component.onCompleted: {
            if(control.groupList.length>0){ //与上一个section不一样就添加
                if(control.groupList[control.groupList.length-1]!==group){
                    control.groupList.push(group)
                    control.indexList.push(index)
                }
            }else{
                control.groupList.push(group)
                control.indexList.push(index)
            }
            if(index===control.count-1){
                //最后设置导航的model
                repeater.model=control.groupList
            }
        }
    }

    //分组/分节
    section{
        //以哪个属性分组
        property: "group"
        //可以指定为完全字符串匹配或者首字母匹配
        criteria: ViewSection.FullString
        //分组标题
        delegate: Rectangle{
            width: ListView.view.width
            height: 35
            color: Qt.rgba(0.3,0.3,0.3,1.0)
            //底部横线
            Rectangle{
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: "black"
            }
            //文本内容
            Text {
                anchors.centerIn: parent
                text: section //对应section.property指定的字段
                color: "white"
            }
        }
        //位置
        labelPositioning: ViewSection.InlineLabels
    }

    //有焦点时才能按键切换
    focus: true
    //跟随当前项移动，默认为true
    highlightFollowsCurrentItem: true
    //竖向滚动条
    ScrollBar.vertical: ScrollBar{}

    Column{
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 20
        spacing: 5
        //最简单的还是listview两级嵌套，第一级为分组，第二级为item
        //这里只是玩下
        Repeater{
            id: repeater
            //初始为空，在构建完后设置
            //model: control.groupList
            delegate: Rectangle{
                width: 40
                height: 40
                color: control.currentSection===modelData?"gray":"white"
                border.color: "black"
                radius: 20
                Text {
                    anchors.centerIn: parent
                    text: modelData
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        control.positionViewAtIndex(control.indexList[index],ListView .Beginning)
                    }
                }
            }
        }
    }

    //数据
    model: ListModel{
        ListElement{ group:"A"; name:"1"; }
        ListElement{ group:"A"; name:"2"; }
        ListElement{ group:"A"; name:"3"; }
        ListElement{ group:"A"; name:"4"; }
        ListElement{ group:"A"; name:"5"; }
        ListElement{ group:"A"; name:"6"; }
        ListElement{ group:"B"; name:"1"; }
        ListElement{ group:"B"; name:"2"; }
        ListElement{ group:"B"; name:"3"; }
        ListElement{ group:"B"; name:"4"; }
        ListElement{ group:"B"; name:"5"; }
        ListElement{ group:"B"; name:"6"; }
        ListElement{ group:"C"; name:"1"; }
        ListElement{ group:"C"; name:"2"; }
        ListElement{ group:"C"; name:"3"; }
        ListElement{ group:"C"; name:"4"; }
        ListElement{ group:"C"; name:"5"; }
        ListElement{ group:"C"; name:"6"; }
        //ListElement{ group:"b"; name:"test"; }
    }
}
