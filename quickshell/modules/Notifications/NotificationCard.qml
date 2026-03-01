import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs

Rectangle {
  id: root
  property var model
  readonly property var modelImage: model.image || model.appIcon || null

  width: 400
  implicitHeight: content.implicitHeight + 16

  radius: 4
  color: Theme.bg2

  Column {
    id: content
    anchors.fill: parent
    anchors.margins: 8
    spacing: 8

    Row {
      spacing: 8
      width: parent.width

      Image {
        id: image
        width: modelImage ? 40 : 0
        height: 40
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: modelImage
        visible: source !== ""
      }

      Column {
        spacing: 4
        width: parent.width - (image.width + content.spacing)

        Text {
          text: model.summary
          color: Theme.fg2
          font.bold: true
          font.pixelSize: 16
          wrapMode: Text.WordWrap
          width: parent.width
        }

        Text {
          text: model.body
          color: Theme.fg0
          font.pixelSize: 12
          wrapMode: Text.WordWrap
          width: parent.width
        }
      }
    }
  
    RowLayout {
      spacing: 8
      width: parent.width

      Repeater {
        model: root.model.actions
        Button {
          id: control
          text: modelData.text
          Layout.fillWidth: true
          Layout.preferredWidth: 0
          height: 32
          background: Rectangle {
            radius: 4
            color: hovered ? Theme.bg0 : Theme.bg1
          }
          contentItem: Text {
            anchors.fill: parent
            text: control.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: Theme.fg1
          }
          onClicked: modelData.invoke()
        }
      }
    }
  }

  Component.onCompleted: {
    enterAnimation.start()
  }

  ParallelAnimation {
    id: enterAnimation

    NumberAnimation {
      target: root
      property: "opacity"
      from: 0
      to: 1
      duration: 200
      easing.type: Easing.OutCubic
    }

    NumberAnimation {
      target: root
      property: "x"
      from: 40
      to: 0
      duration: 200
      easing.type: Easing.OutCubic
    }
  }

  ParallelAnimation {
    id: expireAnimation

    NumberAnimation {
      target: root
      property: "opacity"
      to: 0
      duration: 200
      easing.type: Easing.InCubic
    }

    NumberAnimation {
      target: root
      property: "x"
      to: 40
      duration: 200
      easing.type: Easing.InCubic
    }

    onFinished: model.dismiss()
  }

  Timer {
    interval: 5000
    running: true
    repeat: false
    onTriggered: expireAnimation.start()
  }
}
