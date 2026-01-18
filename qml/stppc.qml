import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow {

    property int currentIndex: 0
    property var currentGame
    property var games
    property string txts

    Component.onCompleted: {
       games = ["blackbox.html","bridges.html","cube.html","flood.html","fifteen.html","filling.html","flip.html"]
       currentGame = games[currentIndex]

    }
    initialPage: Component { Game { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

}
