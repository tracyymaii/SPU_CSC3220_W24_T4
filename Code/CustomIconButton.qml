import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import "Database.js" as JS

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
        onClicked: {buttonClicked()}
    }

    function buttonClicked(){
        let res = JS.dbGetUserInfo(0);
        homePage.userData = Qt.binding(() => {return new Object({uname: res.uname, pname: res.pname, notif: res.notifs})})

        appPage.visible = false
        dest.visible = true
    }
}
