import QtQuick 2.2

Rectangle {
    id: slot
    property bool empty: true

    width: 10
    height: 10
    radius: 5

    border.color: "white"
    border.width: 1

    color: empty?"transparent":"white"

    MouseArea {
        anchors.fill: parent
        drag.target: parent
        onClicked: {
            slot.empty = !slot.empty
        }
    }
}
