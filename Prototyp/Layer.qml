import QtQuick 2.2
import QtGraphicalEffects 1.0

Rectangle {
    id: layer

    property alias name: headerText.text
    property alias text: description.text

    property bool hasInput: true
    property bool hasOutput: true

    property alias inputSlot: inputSlot
    property alias outputSlot: outputSlot

    property Item inputLayer
    //property Item outputLayer

    property bool compact: false

    default property alias children: content.children

    width: 150
    height: 150

    gradient: Gradient {
            //GradientStop { position: 0.0; color: Qt.lighter(layer.color, 1.5)}
            GradientStop { position: (headerText.height / layer.height); color: layer.color}
            GradientStop { position: 1; color: Qt.darker(layer.color, 1.1)}
    }
    border.width: 1
    border.color: "#80FFFFFF"
    radius: 5

    onXChanged: {
        inputSlot.xChanged()
        outputSlot.xChanged()
    }
    onYChanged: {
        inputSlot.yChanged()
        outputSlot.yChanged()
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        drag.target: parent
        cursorShape: Qt.SizeAllCursor
        hoverEnabled: true
    }

    LayerName {
        id: headerText

        anchors.top: layer.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: content

        visible: !layer.compact
        anchors.top: headerText.bottom
        anchors.topMargin: 5
        anchors.bottom: description.top
        anchors.bottomMargin: 5
        anchors.left: layer.left
        anchors.right: layer.right
    }

    LayerDescription {
        id: description
        visible: !layer.compact
        anchors.bottom: layer.bottom
        anchors.left: layer.left
        anchors.right: layer.right
        anchors.margins: 5

        onClicked: {
            layer.hidden.toogle()
        }
    }

    Slot {
        id: inputSlot

        visible: layer.hasInput && !layer.compact

        anchors.verticalCenter: headerText.verticalCenter
        anchors.left: layer.left
        anchors.leftMargin: y
    }

    Slot {
        id: outputSlot

        visible: layer.hasOutput && !layer.compact

        anchors.verticalCenter: headerText.verticalCenter
        anchors.right: layer.right
        anchors.rightMargin: y
    }
}
