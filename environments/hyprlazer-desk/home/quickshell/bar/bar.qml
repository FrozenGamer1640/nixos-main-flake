pragma Singleton

import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text


Singleton {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData

      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30

      Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(root.clock.date, "hh:mm:ss ap - yyyy/MM/dd")
      }
    }
  }

  SystemClock {
    id: clock
  }
}

