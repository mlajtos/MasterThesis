import QtQuick 2.0

Image {
    id: activation

    property string name: "blank"
    property bool highlighted: false
    property alias containsMouse: mouse.containsMouse
    signal positionChanged(var mouse)
    signal highlightPos(int x, int y, int w, int h)
    signal toogleHighlight(bool value)

    property rect highlightRect: Qt.rect(0, 0, width, height)

    source: "images/" + name + ".png"
    fillMode: Image.PreserveAspectFit

    scale: mouse.pressed ? 3 : 1
    z: mouse.pressed ? 10 : 1

    onHighlightPos: {
        highlightRect.x = x - w / 2
        highlightRect.y = y - h / 2
        highlightRect.width = w
        highlightRect.height = h
    }

    onToogleHighlight: {
        highlighted = value

        if (!highlighted) {
            highlightRect = Qt.rect(0, 0, width, height)
        }
    }

    Behavior on scale {
        NumberAnimation { easing.type: Easing.InOutQuad; duration: 100  }
    }

    Rectangle {
        id: frame

        x: highlightRect.x - border.width
        y: highlightRect.y - border.width
        width: highlightRect.width + 2 * border.width
        height: highlightRect.height + 2 * border.width

        color: "transparent"
        radius: 2

        border.color: (activation.highlighted || mouse.containsMouse) ? "yellow" : "#80000000"
        border.width: 1

        Behavior on border.color { ColorAnimation { } }
        Behavior on x { SmoothedAnimation { } }
        Behavior on y { SmoothedAnimation { } }
        Behavior on width { SmoothedAnimation { } }
        Behavior on height { SmoothedAnimation { } }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true

        onPositionChanged: activation.positionChanged(mouse)

        cursorShape: Qt.CrossCursor
    }
}
