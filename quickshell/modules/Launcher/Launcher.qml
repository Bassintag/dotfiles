import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Widgets
import qs

Scope {
  id: launcher
  property string query: ""

  function close() {
    root.visible = false;
    launcher.query = ""
  }

  function launchSelected() {
    if (list.currentItem && list.currentItem.modelData) {
        list.currentItem.modelData.execute();
        launcher.close();
    }
  }


  Window {
    id: root
    color: "transparent"
    visible: false

    height: 320
    width: 640

    Rectangle {
      implicitWidth: root.width
      implicitHeight: root.height
      radius: 4

      color: Theme.bg2
    }

    Rectangle {
      x: 2
      y: 2
      implicitWidth: root.width - 4
      implicitHeight: root.height - 4
      radius: 4

      color: Theme.bg0
    }

    ColumnLayout {
      anchors.fill: parent
      anchors.topMargin: 18
      anchors.leftMargin: 16
      anchors.rightMargin: 16
      spacing: 16

      TextField {
        id: searchField
        Layout.fillWidth: true
        placeholderText: "Search"
        placeholderTextColor: Theme.bg3
        color: Theme.fg2
        focus: true
        font.pixelSize: 18
        padding: 8
        text: launcher.query;
        
        background: Rectangle {
          border.color: Theme.bg2
          color: Theme.bg1
        }

        onTextChanged: {
          launcher.query = text;
          list.currentIndex = filtered.values.length > 0 ? 0 : -1;
        }

        Keys.onEscapePressed: launcher.close()
        Keys.onPressed: event => {
            const ctrl = event.modifiers & Qt.ControlModifier;
            if (event.key == Qt.Key_Up || event.key == Qt.Key_P && ctrl) {
              event.accepted = true;
              if (list.currentIndex > 0)
                list.currentIndex--;
            } else if (event.key == Qt.Key_Down || event.key == Qt.Key_N && ctrl) {
              event.accepted = true;
              if (list.currentIndex < list.count - 1)
                list.currentIndex++;
            } else if ([Qt.Key_Return, Qt.Key_Enter].includes(event.key)) {
              event.accepted = true;
              launcher.launchSelected();
            } else if (event.key == Qt.Key_C && ctrl) {
              event.accepted = true;
              launcher.close();
            }
        }

      }

      ScriptModel {
        id: filtered
        values: {
          let entries = DesktopEntries.applications.values;
          const q = launcher.query.trim().toLowerCase();
          if (q) {
            entries = entries.filter(d => d.name && d.name.toLowerCase().includes(q))
          }
          return entries
        }
      }

      ListView {
        id: list
        model: filtered.values
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        currentIndex: filtered.values.length > 0 ? 0 : -1
        keyNavigationWraps: true
        highlight: Rectangle {
          radius: 4
          opacity: 0.5
          color: Theme.bg2
        }

        delegate: RowLayout {
          id: entry
          required property var modelData
          required property int index
          height: 32
          width: list.width
          Layout.fillWidth: true
          spacing: 12

          IconImage {
            Layout.leftMargin: 8
            source: Quickshell.iconPath(modelData.icon, true)
            width: 16
            height: 16
          }

          Text {
            Layout.rightMargin: 8
            Layout.fillWidth: true
            text: modelData.name
            color: Theme.fg2
            font.pixelSize: 16
          }
        }
      }
    }

    Keys.onReturnPressed: launcher.launchSelected()
  }

  GlobalShortcut {
    description: "Open launcher"
    name: "launcher"

    onPressed: () => {
      root.visible = true
    }
  }
}
