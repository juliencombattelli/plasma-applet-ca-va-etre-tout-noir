import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.2

Item {
    property alias cfg_onScript: onScript.text
    property alias cfg_offScript: offScript.text
    property alias cfg_state: state.checked 

    ColumnLayout {
        GridLayout {
            columns: 2
            
            Label {
                Layout.row: 0
                Layout.column: 0
                text: i18n("On-Script")
            }
            TextField {
                id: onScript
                Layout.row: 0
                Layout.column: 1
                Layout.minimumWidth: 300
            }
            
            Label {
                Layout.row: 1
                Layout.column: 0
                text: i18n("Off-Script")
            }
            TextField {
                id: offScript
                Layout.row: 1
                Layout.column: 1
                Layout.minimumWidth: 300
            }

            CheckBox {
                id: state
                visible: false
            }
        }
    }
}
