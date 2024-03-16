import QtQuick
import QtQuick.Controls
import QtQuick.Effects



Rectangle {
    id: settingedit
    color: "white"

    width: appPage.width * 0.7
    height: appPage.width * 0.09
    radius: 8

    property var appPage
    property string contentLeft
    property string contentRight
    property string currentText

    Row{
        spacing:0

        Rectangle {
            width: settingedit.width * 0.5
            height: appPage.width * 0.09
            radius: 8

            Text{
                id:leftText
                text:qsTr(contentLeft)
                font.pointSize: 12
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
            }
        }

        Rectangle {
            width: settingedit.width * 0.5
            height: appPage.width * 0.09
            radius: 8

            TextInput{
                id:rightText
                text:qsTr(contentRight)
                font.pointSize: 12
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
                focus: false
                onTextChanged: newTextData = rightText.text
            }
        }
    }



}
