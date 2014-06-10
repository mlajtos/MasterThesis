import QtQuick 2.2

Text {
    color: "white"
    text: "Generic description"
    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    elide: Text.ElideRight
    textFormat: Text.RichText
    font.italic: true

    signal clicked

    font.pixelSize: 12
    horizontalAlignment: Text.AlignHCenter

    MouseArea {
        id: mouse
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onClicked: parent.clicked()
    }
}
