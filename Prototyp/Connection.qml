import QtQuick 2.2

Canvas {
    id: canvas

    property Item begin
    property Item end

    property color lineColor: "#80FFFFFF"
    property real lineWidth: 1

    visible: !begin.empty && !end.empty

    width: 1000
    height: 1000

    onBeginChanged: {
        if (begin) {
            begin.xChanged.connect(canvas.update)
            begin.yChanged.connect(canvas.update)
        }
    }

    onEndChanged: {
        if (end) {
            end.xChanged.connect(canvas.update)
            end.yChanged.connect(canvas.update)
        }
    }

    signal update

    onUpdate: {
        var p1 = canvas.parent.mapFromItem(begin, begin.width / 2, begin.height / 2)
        var p2 = canvas.parent.mapFromItem(end, end.width / 2, end.height / 2)

        canvas.x = Math.min(p1.x, p2.x)
        canvas.y = Math.min(p1.y, p2.y)

        canvas.requestPaint()
    }

    z: 1

    onPaint: {
        if (!begin || !end) {
            return
        }

        var p1 = canvas.mapFromItem(begin, begin.width / 2, begin.height / 2)
        var p2 = canvas.mapFromItem(end, end.width / 2, end.height / 2)

        var ctx = canvas.getContext('2d')
        ctx.clearRect(0, 0, canvas.canvasSize.width, canvas.canvasSize.height)
        ctx.beginPath();
        ctx.moveTo(p1.x, p1.y);
        ctx.bezierCurveTo((p1.x+p2.x) / 2, p1.y, (p1.x+p2.x) / 2, p2.y, p2.x, p2.y);
        ctx.lineWidth = canvas.lineWidth
        ctx.strokeStyle = canvas.lineColor
        ctx.stroke()
    }
}
