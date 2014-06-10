import QtQuick 2.2

Layer {
    id: layer
    name: "Three"
    color: "#C01f77b4"
    hasInput: false
    text: "Provide 28&times;28 pixel image."

    width: 100
    height: 130

    signal highlightPos(int x, int y, int w, int h)
    signal toogleHighlight(bool highlight)

    onHighlightPos: act.highlightPos(x, y, w, h)
    onToogleHighlight: act.toogleHighlight(highlight)

    Activation {
        id: act
        name: "DataLayer/activation0"
        anchors.centerIn: parent
    }


}
