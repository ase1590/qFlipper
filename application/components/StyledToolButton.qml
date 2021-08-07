import QtQml 2.12
import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: control
    property alias icon: button.icon.source

    width: 50
    height: width

    signal pressed
    signal released
    signal shortPress
    signal longPress
    signal repeat

    function setPressed() {
        button.down = true;
        pressed();
    }

    function setReleased() {
        button.down = false;
        released();
    }

    onPressed: {
        if(!longTimer.running) {
            longTimer.start();
        }

        if(shortTimer.running) {
           shortTimer.stop();
        }
    }

    onReleased: {
        if(longTimer.running) {
            longTimer.stop();
            shortTimer.start();
        }

        if(repeatTimer.running) {
            repeatTimer.stop();
        }
    }

    onLongPress: {
        if(!repeatTimer.running) {
            repeatTimer.start();
        }
    }

    ToolButton {
        id:button
        anchors.fill: parent

        icon.color: "white"
        icon.width: 32
        icon.height: 32

        onPressed: control.pressed()
        onReleased: control.released()
    }

    Timer {
        id: shortTimer
        repeat: false
        interval: 1
        onTriggered: control.shortPress()
    }

    Timer {
        id: longTimer
        repeat: false
        interval: 350
        onTriggered: control.longPress()
    }

    Timer {
        id: repeatTimer
        repeat: true
        interval: 150
        onTriggered: control.repeat()
    }
}
