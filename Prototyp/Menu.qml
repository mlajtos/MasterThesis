import QtQuick 2.0

Item {
    default property alias children: col.children

    width: 100
    height: 62

    Rectangle {
        id: menu
        radius: 10
        color: Qt.rgba(1,1,1,0.3)
        anchors.fill: col
        anchors.margins: -10

        MouseArea {
            drag.target: col
            anchors.fill: parent
        }
    }

    Column {
        id: col
        spacing: 5

        x: 100
        y: 100

        width: 130
    }
}
