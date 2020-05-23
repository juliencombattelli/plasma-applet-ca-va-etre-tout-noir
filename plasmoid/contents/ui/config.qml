import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.2

Item {
    id: configPage

    property alias cfg_startupScript: startupScript.text
    property alias cfg_onScript: onScript.text
    property alias cfg_offScript: offScript.text

    ColumnLayout {
        GridLayout {
            columns: 2
            
            Label {
                Layout.row: 2
                Layout.column: 0
                text: i18n("Startup-Script")
            }
            TextField {
                id: startupScript
                Layout.row: 2
                Layout.column: 1
                Layout.minimumWidth: 300
            }

            Label {
                Layout.row: 2
                Layout.column: 0
                text: i18n("On-Script")
            }
            TextField {
                id: onScript
                Layout.row: 2
                Layout.column: 1
                Layout.minimumWidth: 300
            }
            
            Label {
                Layout.row: 5
                Layout.column: 0
                text: i18n("Off-Script")
            }
            TextField {
                id: offScript
                Layout.row: 5
                Layout.column: 1
                Layout.minimumWidth: 300
            }
        }
    }
}
