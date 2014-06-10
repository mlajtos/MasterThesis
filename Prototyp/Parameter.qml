import QtQuick 2.0

Text {
    id: parameter
    text: "X"
    color: "white"
    font.weight: Font.Black
    textFormat: Text.RichText

    property alias mouse: mouse

    signal increase
    signal decrease


    Rectangle {
        color: mouse.containsMouse ? "#80000000" : "transparent"

        Behavior on color {
            ColorAnimation { duration: 250 }
        }

        anchors.fill: parent
        anchors.margins: -3

        z: -1
        radius: 5

        MouseArea {
            id: mouse
            anchors.fill: parent
            cursorShape: Qt.SplitHCursor
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            drag.target: dragHandle
            drag.axis: Drag.XAxis

            onReleased: {
                dragHandle.x = 0
            }

            Rectangle {
                id: dragHandle
                color: Qt.rgba(1,1,1,0.1)
                width: parent.width
                height: parent.height

                onXChanged: {
                    console.log(x / 20)
                }
            }
        }
    }
}

