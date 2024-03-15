import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Rectangle {
    id: iconButton
    width: appPage.width * 0.1
    height: appPage.width * 0.1
    color: appPage.color

    property string iconSource
    property var appPage
    property var dest

    Image {
        source: iconSource
        width: parent.width
        height: parent.height
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
