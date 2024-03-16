import QtQuick
import QtQuick.Controls
import QtQuick.Effects



Rectangle {
    id: settingbox
    color: "white"

    width: appPage.width * 0.7
    height: appPage.width * 0.09
    radius: 8

    property var appPage
    property string contentLeft
    property string contentRight


        Rectangle {
            width: settingbox.width * 0.5
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
}
