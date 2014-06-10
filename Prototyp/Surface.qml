import QtQuick 2.0

Rectangle {
    default property alias children: rootItem.children

    Image {
        source: "images/blueprint-black.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    PinchArea {
        id: pinchArea
        anchors.fill: parent

        onPinchStarted: {
            //rootScale.origin.x -= rootItem.parent.mapFromItem(pinchArea, pinch.startCenter.x, pinch.startCenter.y).x
            //rootScale.origin.y -= rootItem.parent.mapFromItem(pinchArea, pinch.startCenter.x, pinch.startCenter.y).y
        }

        onPinchUpdated: {
            var dz = (pinch.scale - pinch.previousScale)
            //rootScale.scale += dz

            var dx = (pinch.center.x - pinch.previousCenter.x) * rootScale.scale
            //rootScale.origin.x += dx

            var dy = (pinch.center.y - pinch.previousCenter.y) * rootScale.scale
            //rootScale.origin.y += dy

            /*
            var dx = (pinch.center.x - pinch.previousCenter.x) * rootScale.scale
            rootScale.origin.x += dx

            var dy = (pinch.center.y - pinch.previousCenter.y) * rootScale.scale
            rootScale.origin.y += dy
            */
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            drag.target: rootItem

            hoverEnabled: true

            onPositionChanged: {
                //rootScale.origin.x = mouse.x * rootScale.scale
                //rootScale.origin.y = mouse.y * rootScale.scale

                //console.log(rootScale.origin.x, rootScale.origin.y)
            }
        }

    }

    Item {
        id: rootItem

        width: 1
        height: 1

        //x: parent.width / 2
        //y: parent.height / 2

        transform: [
            Translate {
                id: rootTranslate
                x: rootScale.origin.x
                y: rootScale.origin.y
            },
            Scale {
                id: rootScale

                property real scale: 1

                xScale: scale
                yScale: scale
                origin.x: 0
                origin.y: 0

                /*
                NumberAnimation on scale {
                    from: 0.5; to: 1.5
                    loops: Animation.Infinite
                    easing.type: Easing.CosineCurve
                    duration: 10000
                }

                /*
                NumberAnimation on origin.x {
                    from: 0; to: 300
                    loops: Animation.Infinite
                    easing.type: Easing.CosineCurve
                    duration: 5000
                }

                NumberAnimation on origin.y {
                    from: 0; to: 300
                    loops: Animation.Infinite
                    easing.type: Easing.SineCurve
                    duration: 5000
                }
                */

            }
        ]

        Slot {
            x: rootScale.origin.x
            y: rootScale.origin.y
            color: "red"
            visible: false
        }
    }
}
