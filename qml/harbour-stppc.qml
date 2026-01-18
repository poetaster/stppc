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
       games = ["blackbox.html","bridges.html","cube.html","dominosa.html","flood.html","fifteen.html",
                "flip.html", "galaxies.html", "inertia.html", "loopy.html","net.html","same.html","sixteen.html"]
       currentGame = games[currentIndex]
       gameNames = ["Blackbox","Bridges","Cube","Dominosa","Flood","Fifteen","Flip","Galaxies","Inertia","Loopy","Net","Samegame","Sixteen"]
       currentGameName = gameNames[currentIndex]

    }
    initialPage: Component { Game { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

}
