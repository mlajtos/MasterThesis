import QtQuick 2.0

Layer {
    id: rectify
    name: "Rectify"
    color: "#C09467bd"
    text: "Propagate only<br>positive inputs."

    width: 170
    height: 225

    signal highlightPos(int index, int x, int y, int w, int h)
    signal toogleHighlight(int index, bool value)

    onHighlightPos: {
        activationsRepeater.itemAt(index).highlightPos(x, y, w, h)
    }
    onToogleHighlight: {
        activationsRepeater.itemAt(index).toogleHighlight(value)
    }

    Grid {
        id: activations
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5
        columns: 3
        rows: 3

        Repeater {
            id: activationsRepeater
            model: convolve.filters

            Activation {
                id: activation
                name: "RectifyLayer/activation" + index

                onContainsMouseChanged: {
                    rectify.inputLayer.toogleHighlight(index, containsMouse)
                }
            }
        }
    }
}
