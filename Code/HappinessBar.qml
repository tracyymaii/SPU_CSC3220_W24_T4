import QtQuick
import QtQuick.Controls

ProgressBar{
    id: happinessBar

    width: parent.width * 0.5
    height: 10
    value: currentRate

    anchors.centerIn: parent

    Rectangle {
        anchors.fill: happinessBar
        color: "light yellow"
        radius: 4
    }

    Rectangle{
        anchors.left: happinessBar.left
        anchors.bottom: happinessBar.bottom
        height: happinessBar.height
        width: happinessBar.value * happinessBar.width
        color: "red"
        radius: 4
    }

    function changeValue(n){
        happinessBar.value = n
    }
}
