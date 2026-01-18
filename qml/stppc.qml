import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow {
    id:root
    property int currentIndex: 0
    property var currentGame
    property var currentGameName
    property var games
    property var gameNames
    property string txts

    Component.onCompleted: {
       games = ["blackbox.html","bridges.html","cube.html","dominosa.html","flood.html","fifteen.html","flip.html", "galaxies.html"]
       currentGame = games[currentIndex]
       gameNames = ["Blackbox","Bridges","Cube","Dominosa","Flood","Fifteen","Flip","Galaxies"]
       currentGameName = gameNames[currentIndex]

    }
    initialPage: Component { Game { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

}
