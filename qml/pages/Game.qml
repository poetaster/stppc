import QtQuick 2.6
import Sailfish.Silica 1.0

import Sailfish.WebView 1.0
import Sailfish.WebEngine 1.0
import "../html/"
import "../html/www.chiark.greenend.org.uk/~sgtatham/puzzles/js"

Page {
    id: gamePage
    property bool debug: true
    property string gameName
    property string gameUrl
    property string lon
    property string docker

    allowedOrientations: Orientation.Portrait
    onOrientationChanged:  {
        if ( orientation === Orientation.Portrait ) {
            if (debug) console.debug("port")
            drawer.open = true
            webview.height = parent.height * 2/3 //_screenHeight * 2/3
            //drawer.width = parent.width //_screenWidth
            //drawer.height = parent.height * 1/3 //_screenHeight * 1/3
            //drawer.dock = Dock.Bottom
            drawer.open = true
        } else {
            if (debug) console.debug("land")
            webview.height = parent.height
            //drawer.width = _screenWidth / 2
            //drawer.height = _screenHeight
            //drawer.dock = Dock.Right
            drawer.open = false
        }
    }
    SilicaFlickable {
        id: flicky
        anchors.fill: parent

        Component.onCompleted: {
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Choose Game")
                onClicked: pageStack.animatorPush(Qt.resolvedUrl("Choose.qml"))
            }
        }

        //contentHeight: webview.height

        WebView {
            id: webview
            width: parent.width
            height: parent.height * 2/3

            anchors {
                //fill:parent
                left: parent.left
                right: parent.right
            }

            /* This will probably be required from 4.4 on. */
            Component.onCompleted: {
                //WebEngineSettings.setPreference("security.disable_cors_checks", true, WebEngineSettings.BoolPref)
                //WebEngineSettings.pixelRatio = 3
                WebEngineSettings.setPreference("security.fileuri.strict_origin_policy", false, WebEngineSettings.BoolPref)
                if (debug) console.debug(webview.height)
                if (debug) console.debug(webview.width)
            }

            url: "../html/www.chiark.greenend.org.uk/~sgtatham/puzzles/js/" + games[currentIndex]

            onViewInitialized: {
                webview.loadFrameScript(Qt.resolvedUrl("../html/framescript.js"));
                webview.addMessageListener("webview:action");

                //webview.runJavaScript("return latlon('" + lat + "','" + lon + "')");
            }
            on_PageOrientationChanged: {
                //if ( data.topic != lon ) {
                //webview.runJavaScript("return latlon('" + lat + "','" + lon + "')");
                //}

            }

            onRecvAsyncMessage: {
                if (debug) console.debug(message)
                switch (message) {
                case "embed:contentOrientationChanged":
                    break
                case "webview:action":
                        if (debug) console.debug(data.topic)
                    break
                }
            }
        }
        /* command() */
        // 2 - gametype
        // 5 new
        // 6 restart
        // 7 undo
        // 8 redo
        Row {
            id: buttonsGame
            anchors.top: webview.bottom
            width: parent.width
            spacing: Theme.paddingMedium
            Button {
                text: "New"
                width: (parent.width - 2 * buttons.spacing) / 2
                onClicked: webview.runJavaScript("return action('5')")
            }
            Button {
                text: "Restart"
                width: (parent.width - 2 * buttons.spacing) / 2
                onClicked: webview.runJavaScript("return action('6')")
            }
        }
        Separator {
            id: sepOne
            width:parent.width
            anchors.top: buttonsGame.bottom
            height: Theme.paddingLarge
        }

        Row {
            id: buttons
            anchors.bottomMargin: Theme.paddingLarge
            anchors.top: sepOne.bottom
            width: parent.width
            spacing: Theme.paddingMedium
            Button {
                text: "Undo"
                width: (parent.width - 2 * buttons.spacing) / 2
                onClicked: webview.runJavaScript("return action('7')")
            }
            Button {
                text: "Redo"
                width: (parent.width - 2 * buttons.spacing) / 2
                onClicked: webview.runJavaScript("return action('8')")
            }
        }

        DockedPanel{
            id: drawer
            visible: true
            width: parent.width
            height: parent.height * 1/5
            dock: Dock.Bottom
           /*
            Label{
                id:gLabel
                text:  helpFields.get(currentIndex).name
            }*/

            TextArea {
                id:descripton
                readOnly: true
                anchors.fill: parent
                text:  helpFields.get(currentIndex).desc
            }
            ListModel {
                 id: helpFields
                 ListElement {
                     name: "Blackbox"
                     desc: " A number of balls are hidden in a rectangular arena. You have to deduce the positions of the balls by firing lasers positioned at the edges of the arena and observing how their beams are deflected.
                        Beams will travel straight from their origin until they hit the opposite side of the arena (at which point they emerge), unless affected by balls in one of the following ways:
  A beam that hits a ball head-on is absorbed and will never re-emerge. This includes beams that meet a ball on the first rank of the arena.
  A beam with a ball in its front-left square and no ball ahead of it gets deflected 90 degrees to the right.
  A beam with a ball in its front-right square and no ball ahead of it gets similarly deflected to the left.
  A beam that would re-emerge from its entry location is considered to be ‘reflected’.
  A beam which would get deflected before entering the arena by a ball to the front-left or front-right of its entry point is also considered to be ‘reflected’. "
                 }
                 ListElement {
                     name: "Cube"
                     desc: "Roll the cube around the grid, picking up the blue squares on its faces. Try to get all the blue squares on to the object at the same time, in as few moves as possible. Tap where you want it to roll towards. After every roll, the grid square and cube face that you brought into contact swap their colours, so that a non-blue cube face can pick up a blue square, but a blue face rolled on to a non-blue square puts it down again."
                    }
                 ListElement {
                     name: "Dominosa"
                     desc: "Tile the rectangle with dominoes (1×2 rectangles) so that every possible domino appears exactly once (that is, every possible pair of numbers, including doubles).
  Click between two adjacent numbers to place or remove a domino. Right-click to place a line between numbers if you think a domino definitely cannot go there. Dominoes light up red if two identical ones appear on the grid. "
                    }
                  ListElement {
                      name:"Flood"
                      desc:"Try to get the whole grid to be the same colour within the given number of moves, by repeatedly flood-filling the top left corner in different colours."
                    }
                  ListElement {
                      name: "Fifteen"
                      desc: "Slide the tiles around the box until they appear in numerical order from the top left, with the hole in the bottom right corner. Click on a tile to slide it towards the hole."
                   }
                  ListElement {
                      name: "Flip"
                      desc: "You have a grid of squares, some light and some dark. Light all the squares up at the same time. Choose any square and flip its state, but when you do so, other squares around it change state as well.
  Each square contains a small diagram showing which other squares change when you flip it."
                  }
                  ListElement {
                      name: "Galaxies"
                      desc: " Draw lines along grid edges so as to divide the grid up into connected regions of squares.
  Every region should have two-way rotational symmetry, should contain exactly one dot which is in its centre, and should contain no lines separating two of its own squares from each other. A region satisfying all of these requirements will be automatically highlighted.
  Click on a grid edge to add or remove a line. Right-click on a dot and drag the mouse to place an arrow in a grid square pointing to that dot, to indicate that you think that square must belong in the same region as that dot. Right-drag an existing arrow to move it, or drop it off the edge of the grid to remove it. "
                  }
                  ListElement {
                      name: "Inertia"
                      desc: " Slide the ball around the grid picking up the gems. Every time the ball moves, it will keep sliding until it either hits a wall, or stops on a stop square (the broken circles). Try to collect every gem without running into any of the mines.
  Alternatively, click on the grid to make the ball move towards where you clicked.
  If you hit a mine and explode, you can select Undo from the Game menu and continue playing; the game will track how many times you died. "
                   }
                  ListElement {
                      name: "Loopy"
                      desc: " Form a single closed loop out of the grid edges, in such a way that every numbered square has exactly that many of its edges included in the loop.
  Click on a grid edge to mark it as part of the loop (black), and again to return to marking it as undecided (yellow). Right-click on a grid edge to mark it as definitely not part of the loop (faint grey), and again to mark it as undecided again.
  When you have mastered the square grid, look in the Type menu for many other types of tiling!  "
                   }
                  ListElement {
                      name: "Net"
                      desc: " Rotate the grid squares so that they all join up into a single connected network with no loops.
  Squares connected to the middle square are lit up. Aim to light up every square in the grid (not just the endpoint blobs).
  When this gets too easy, select a 'wrapping' variant from the Type menu to enable grid lines to run off one edge of the playing area and come back on the opposite edge!"
                  }
                  ListElement {
                      name: "Rectangles"
                      desc: " Draw lines along the grid edges to divide the grid into rectangles, so that each rectangle contains exactly one numbered square and its area is equal to the number written in that square. Click on a single grid edge to draw or erase it. "
                 }
                  ListElement {
                      name: "Same Game"
                      desc: "Try to empty the playing area completely, by removing connected groups of two or more squares of the same colour. Then try to score as much as possible, by removing large groups at a time instead of small ones.
  Click on a coloured square to highlight the rest of its connected group. The status line will print the number of squares selected, and the score you would gain by removing them. Click again to remove the group; other squares will fall down to fill the space, and if you empty a whole column then the other columns will move up. You cannot remove a single isolated square: try to avoid dead-end positions where all remaining squares are isolated. "
                  }
                  ListElement {
                      name: "Sixteen"
                      desc: "Slide the grid squares around so that the numbers end up in consecutive order from the top left corner. "
                  }
                  ListElement {
                      name: "Unruly"
                      desc: " Colour every square either black or white, in such a way that:
 no three consecutive squares, horizontally or vertically, are the same colour
 each row and column contains the same number of black and white squares."
                  }
             }
        }
        IconButton{
            id: upButton
            anchors {
                horizontalCenter: parent.horizontalCenter;
                bottom: parent.bottom
            }
            visible: ! drawer.open
            icon.source: "image://theme/icon-m-up"
            onClicked: drawer.open = true

        }

    }
}
