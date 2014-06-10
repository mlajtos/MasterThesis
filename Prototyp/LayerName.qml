import QtQuick 2.2

TextEdit {
    id:layerName
    text: "Default"

    color: "white"
    font.pixelSize: 16

    Keys.onReturnPressed: layerName.focus = false
    Keys.onEscapePressed: layerName.focus = false

    selectionColor: Qt.lighter(parent.color)

    Rectangle {
        color: (layerName.activeFocus || mouseTextEdit.containsMouse) ? Qt.darker(layerName.parent.color) : "transparent"

        Behavior on color {
            ColorAnimation { duration: 250 }
        }

        anchors.fill: parent
        anchors.topMargin: -3
        anchors.bottomMargin: -3
        anchors.leftMargin: -5
        anchors.rightMargin: -5

        z: -1
        radius: 5

        MouseArea {
            id: mouseTextEdit
            anchors.fill: parent
            cursorShape: Qt.IBeamCursor
            onClicked: {
                if (!layerName.activeFocus) {
                    layerName.forceActiveFocus();
                    layerName.selectAll()
                } else {
                    layerName.focus = false;
                }
            }
            hoverEnabled: true
        }
    }
}
