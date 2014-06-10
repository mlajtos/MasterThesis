import QtQuick 2.0
import QtQuick.Layouts 1.1

Layer {
    id: classify
    name: "Classify"
    color: "#C0bcbd22"
    text: "Calculate categorical probabilities of input."

    hasOutput: false

    property var classes: [1,4,7]
    property var probs: [0.11,0.106,0.1]

    width: 150
    height: 140

    signal highlightPos(int index, int x, int y, int w, int h)
    signal toogleHighlight(int index, bool value)

    onHighlightPos: {
        activationsRepeater.itemAt(index).highlightPos(x, y, w, h)
    }
    onToogleHighlight: {
        activationsRepeater.itemAt(index).toogleHighlight(value)
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 5

        Repeater {
            model: 3

            RowLayout {
                Label {
                    text: classify.classes[index]
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignCenter
                }

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Rectangle {
                        anchors.fill: parent
                        anchors.topMargin: 6
                        anchors.bottomMargin: 6
                        radius: 2
                        color: "#30FFFFFF"
                    }

                    Rectangle {
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 6
                        anchors.bottomMargin: 6
                        width: parent.width * classify.probs[index]
                        radius: 2
                    }
                }

                Label {
                    text: Math.floor(classify.probs[index] * 100) + "%"
                    Layout.alignment: Qt.AlignCenter
                    font.pixelSize: 12
                }
            }
        }
    }
}
