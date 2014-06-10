import QtQuick 2.0
import QtQuick.Layouts 1.1

Layer {
    id: convolve
    name: "Convolve"
    color: "#C02ca02c"
    text: "Convolve input with " + filters + "<br>" + filterSize + "&times;" + filterSize + " filters at " + strideSize + "&times;" + strideSize + " stride."

    property Item hidden: hidden

    property int filters: 9
    property int filterSize: 5
    property int strideSize: 1

    width: 170
    height: 375

    signal highlightPos(int x, int y, int w, int h)
    signal toogleHighlight(int index, bool value)

    onHighlightPos: {
        act.highlightPos(x, y, w, h)
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
            model: convolve.filters

            Activation {
                id: activation
                name: "ConvolutionalLayer/activation" + index

                scale: 1 / convolve.strideSize

                onContainsMouseChanged: {
                    filtersRepeater.itemAt(index).toogleHighlight(containsMouse)
                    convolve.inputLayer.toogleHighlight(containsMouse)
                }
                onPositionChanged: convolve.inputLayer.highlightPos(mouse.x, mouse.y, convolve.filterSize * 2, convolve.filterSize * 2)
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
                    target: convolve
                    height: 225
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
                        target: convolve;
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
                        text: "Filters:"
                        Layout.alignment: Qt.AlignRight
                    }

                    Label {
                        text: "Filter size:"
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
                        text: convolve.filters

                        mouse.onClicked: {
                            if (mouse.button === Qt.LeftButton) {
                                convolve.filters += 1
                            } else {
                                convolve.filters -= 1
                            }
                        }
                    }

                    Parameter {
                        text: convolve.filterSize + "&times;" + convolve.filterSize
                    }

                    Parameter {
                        text: convolve.strideSize + "&times;" + convolve.strideSize

                        mouse.onClicked: {
                            if (mouse.button === Qt.LeftButton) {
                                convolve.strideSize += 1
                            } else {
                                convolve.strideSize -= 1
                            }
                        }
                    }

                }
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignCenter

                Label {
                    text: "Filters"
                }
                Grid {
                    columns: 3
                    spacing: 5

                    Repeater {
                        id: filtersRepeater
                        model: convolve.filters


                        Activation {
                            id: filter
                            name: "ConvolutionalLayer/filter" + index

                            onContainsMouseChanged: {
                                activationsRepeater.itemAt(index).toogleHighlight(containsMouse)
                            }
                        }
                    }
                }
            }
        }
    }
}
