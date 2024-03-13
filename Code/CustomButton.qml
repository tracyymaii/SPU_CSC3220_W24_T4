import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Rectangle {
    id: button
    color: "pink"
    height: contentTxt.height * 1.2
    width: contentTxt.width * 1.2
    border.width: button.height * 0.1
    border.color: "white"
    radius: 8

    property string content
    property real fontSize: 0
    property bool fontBold: false
    property var dest
    property var appPage

    Text {
        id: contentTxt
        text: qsTr(content)
        font.pointSize: fontSize !== 0? fontSize: contentTxt.font.pointSize
        font.bold:fontBold
        anchors.centerIn: parent
    }

    MouseArea{
        anchors.fill: parent
        onClicked: buttonClicked()
    }

    function buttonClicked(){
        appPage.visible = false
        dest.visible = true
    }
}
