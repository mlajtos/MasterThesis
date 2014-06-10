import QtQuick 2.0

Layer {
    name: "Normalize"
    color: "#C0ff7f0e"
    text: "Normalize input."

    width: 100
    height: 120

    Activation {
        name: "NormalizeLayer/activation0"
        anchors.centerIn: parent
    }
}
