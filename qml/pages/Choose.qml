import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    allowedOrientations: Orientation.Portrait
    property var games
    SilicaListView {
        id: listView
        model:14
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Choose")
        }
        Component.onCompleted: {
            games = ["Blackbox","Cube","Dominosa","Flood","Fifteen","Flip","Galaxies","Inertia", "Loopy","Net", "Rectangles", "Same Game","Sixteen","Unruly"]

        }

        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.horizontalPageMargin
                text: games[index]
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                highlighted: index === root.currentIndex
            }
            onClicked: {
                currentIndex = index
                pageStack.pop()
            }
        }
        VerticalScrollDecorator {}
    }
}
