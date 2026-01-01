pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick


Singleton {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData

      screen: modelData
      implicitHeight: 30

      anchors {
        top: true
        left: true
        right: true
      }

      Row {
        Text { text: "placeholder" }
        Row {
          Text {
            anchors.centerIn: parent
            text: Qt.formatDateTime(root.clock.date, "hh:mm:ss ap - yyyy/MM/dd")
          }
        }
      }
    }
  }

  SystemClock {
    id: clock
  }
}

