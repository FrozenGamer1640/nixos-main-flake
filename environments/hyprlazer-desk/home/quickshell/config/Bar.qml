import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick


Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      implicitHeight: 40

      anchors {
        top: true
        left: true
        right: true
      }

      Rectangle {
        anchors {
          fill: parent
          verticalCenter: parent.verticalCenter
        }
        color: "#999"

        Row {
          anchors {
            verticalCenter: parent.verticalCenter
            fill: parent
            margins: 5
          }
          spacing: 5

          Rectangle {
            height: parent.height
            width: height * 1.4
            radius: 5
          }
          Rectangle {
            height: parent.height
            width: height * 1.4
            radius: 5
          }
        }
        Row {
          anchors {
            verticalCenter: parent.verticalCenter
            fill: parent
            margins: 5
          }
          spacing: 5
          layoutDirection: Qt.rightToLeft
          LayoutMirroring.enabled: true

          Rectangle {
            height: parent.height
            width: 300

            Text {
              anchors.centerIn: parent

              text: Qt.formatDateTime(clock.date, "hh:mm:ss ap - yyyy/MM/dd")
            }
          }
          Rectangle {
            height: parent.height
            width: 90

            Text {
              anchors.centerIn: parent

              text: "FrozenFox"
            }
          }
          Rectangle {
            height: parent.height
            width: 50

            Text {
              anchors.centerIn: parent
              text: { return UPower.devices.values.length; }
            }
          }
        }
      }
    }
  }

  SystemClock {
    id: clock
  }
}

