import QtQuick 2.2

Surface {
    width: 900
    height: 700

    SimpleDataLayer {
        id: three

        outputSlot.empty: false
    }

    ConvolveLayer {
        id: convolve
        inputLayer: three
        inputSlot.empty: false
        outputSlot.empty: false

        x: 120
    }

    RectifyLayer {
        id: rectify
        inputLayer: convolve
        inputSlot.empty: false
        outputSlot.empty: false

        x: 310
    }

    PoolLayer {
        id: pool
        inputLayer: rectify
        inputSlot.empty: false
        outputSlot.empty: false

        x: 500
    }

    ConnectLayer {
        id: connect
        inputLayer: pool
        inputSlot.empty: false
        outputSlot.empty: false
        x: 680
    }

    ClassifyLayer {
        id: classify
        inputLayer: connect
        inputSlot.empty: false
        x: 850
    }

    Menu {
        x: 300
        y: 300

        NormalizeLayer {
            id: normalizeInMenu
            height: 120
            width: parent.width
        }

        Repeater {
            model: FakeModel { }

            Layer {
                name: model.name
                color: model.color
                width: parent.width
                height: 29
                compact: true
            }
        }
    }

    Connection {
        id: connection

        begin: three.outputSlot
        end: convolve.inputSlot
    }

    Connection {
        id: connection2

        begin: convolve.outputSlot
        end: rectify.inputSlot
    }

    Connection {
        id: connection3

        begin: rectify.outputSlot
        end: pool.inputSlot
    }

    Connection {
        id: connection4

        begin: pool.outputSlot
        end: connect.inputSlot
    }

    Connection {
        id: connection5

        begin: connect.outputSlot
        end: classify.inputSlot
    }

    Connection {
        id: connection6

        begin: three.outputSlot
        end: normalizeInMenu.inputSlot
    }

    Connection {
        id: connection7

        begin: three.outputSlot
        end: handle
    }

    Slot {
        id: handle
    }

}
