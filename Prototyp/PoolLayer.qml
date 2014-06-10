import QtQuick 2.0
import QtQuick.Layouts 1.1

Layer {
    id: pool
    name: "Pool"
    color: "#C0d62728"
    text: "Pool input with " + poolSize + "&times;" + poolSize + " blocks at " + strideSize + "&times;" + strideSize + " stride."

    property Item hidden: hidden

    property int poolSize: 2
    property int strideSize: 2

    width: 160
    height: 220

    signal highlightPos(int x, int y, int w, int h)
    signal toogleHighlight(int index, bool value)

    onHighlightPos: {
        //act.highlightPos(x, y, w, h)
    }
    onToogleHighlight: {
        filtersRepeater.itemAt(index).toogleHighlight(value)
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
            model: 9

            Activation {
                id: activation
                name: "PoolLayer/activation" + index

                onContainsMouseChanged: {
                    pool.inputLayer.toogleHighlight(index, containsMouse)
                }
                onPositionChanged: pool.inputLayer.highlightPos(index, mouse.x * pool.strideSize, mouse.y * pool.strideSize, pool.poolSize * 2, pool.poolSize * 2)
            }
        }
    }

    Item {
        id: hidden

        states: [
            State {
                name: "hidden"
                PropertyChanges {
                    target: parameters
                    opacity: 0
                }
                PropertyChanges {
                    target: pool
                    height: 155
                }
            }
        ]

        transitions: [
            Transition {
                from: ""
                to: "hidden"
                reversible: true
                SequentialAnimation {
                    NumberAnimation {
                        target: parameters
                        property: "opacity"
                        duration: 100
                        easing.type: Easing.OutInQuad
                    }
                    NumberAnimation {
                        target: pool;
                        property: "height";
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        ]

        signal toogle()

        anchors.top: activations.bottom
        anchors.topMargin: 10

        anchors.bottom: parent.bottom

        anchors.left: parent.left
        anchors.right: parent.right

        onToogle: this.state = this.state === "hidden" ? "" : "hidden"

        Rectangle {
            anchors.fill: parent

            color: "#30000000"
            anchors.leftMargin: 1
            anchors.rightMargin: 1
        }

        ColumnLayout {
            id: parameters

            anchors.fill: parent
            anchors.margins: 10

            RowLayout {
                id: parametersRow

                Layout.alignment: Qt.AlignVCenter

                ColumnLayout {
                    id: labelsColumn

                    Layout.preferredWidth: parent.width / 2

                    Label {
                        text: "Pool size:"
                        Layout.alignment: Qt.AlignRight
                    }

                    Label {
                        text: "Stride size:"
                        Layout.alignment: Qt.AlignRight
                    }

                }

                ColumnLayout {
                    id: parametersColumn

                    Layout.preferredWidth: parent.width / 2

                    Parameter {
                        text: pool.poolSize + "&times;" + pool.poolSize
                    }

                    Parameter {
                        text: pool.strideSize + "&times;" + pool.strideSize
                    }

                }
            }
        }
    }
}
