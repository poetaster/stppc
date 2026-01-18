import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Label {
        id: label
        anchors.bottom: cImage.top
        padding: 20
        horizontalAlignment: parent.horizontalCenter
        text: root.gameNames[currentIndex]
    }
    Image {
        id: cImage
        asynchronous: true
        width: 380
        height: 380
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        source:"../img/"+root.gameNames[currentIndex]+"-web.png"
    }

    property var games
    Component.onCompleted: {


    }
/*
    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-next"
        }

        CoverAction {
            iconSource: "image://theme/icon-cover-pause"
        }
    }*/

}
