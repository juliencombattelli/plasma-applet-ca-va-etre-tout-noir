import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponent

Item {
    id: root

	property alias sw_checked: sw.checked
	property alias sw_startupScript: sw.startupScript

	PlasmaCore.DataSource {
		id: executable
		engine: "executable"
		connectedSources: []
		onNewData: {
			var exitCode = data["exit code"]
			var exitStatus = data["exit status"]
			var stdout = data["stdout"]
			var stderr = data["stderr"]
			exited(sourceName, exitCode, exitStatus, stdout, stderr)
			disconnectSource(sourceName)
		}
		function exec(cmd) {
			if (cmd) {
				connectSource(cmd)
			}
		}
		signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
	}

	Connections {
		target: executable
		onExited: {
			console.log("executable exited #####")
			console.log("cmd:", cmd)
			console.log("exitCode:", exitCode)
			if (cmd == sw_startupScript) {
				switch(exitCode) {
				case 0:
					console.log("switching off")
					sw.checked = false
					break;
				case 1:
					console.log("switching on")
					sw.checked = true
					break;
				default:
					console.log("not switching")
					// leave Switch state unmodified
				} 
			}
		}
	}

	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

	Plasmoid.compactRepresentation: PlasmaComponent.Switch {
		id: sw

		property string startupScript: Plasmoid.configuration.startupScript
		property string onScript: Plasmoid.configuration.onScript
		property string offScript: Plasmoid.configuration.offScript

		onClicked: {
			if (checked) {
				executable.exec(onScript)
			} else {
				executable.exec(offScript)
			}
		}

		Component.onCompleted: {
        	executable.exec(startupScript)
    	}
    }
}