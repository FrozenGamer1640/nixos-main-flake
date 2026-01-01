import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text


PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30

  SystemClock {
    id: clock
  }

  Text {
    anchors.centerIn: parent
    text: Qt.formatDateTime(clock.date, "hh:mm:ss ap - yyyy/MM/dd")
  }
}
