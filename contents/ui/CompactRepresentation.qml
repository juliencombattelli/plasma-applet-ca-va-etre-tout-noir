import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponent
	
PlasmaComponent.Switch {
    property string onScript: Plasmoid.configuration.onScript
    property string offScript: Plasmoid.configuration.offScript

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
			// console.log("executable exited")
		}
	}

    onClicked: {
		Plasmoid.configuration.state = checked
        if (checked) {
            executable.exec(onScript)
        } else {
            executable.exec(offScript)
        }
    }

    Component.onCompleted: {
		checked = Plasmoid.configuration.state
    }
}