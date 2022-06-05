import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
// import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
	id: root

	// width: displayContent.width
	// height: displayContent.height
	// root.Layout.minimumWidth: 120
	// root.Layout.minimumHeight: 12
	// root.Layout.maximumWidth = 320
	// root.Layout.maximumHeight = 48
	width: 320
	height: 8


	property var metadata: mpris2Source.multiplexData
		? mpris2Source.multiplexData.Metadata
		: undefined

	property string trackTitle: {
		if (!metadata) return "no metadata title found"
		if (metadata["xesam:title"]) return metadata["xesam:title"]
		if (metadata["xesam:url"]) return metadata["xesam:url"].toString()
		return "untitled"
		return "yadda"
	}

	property string artist: {
		if (!metadata) return "no metadata artist found"
		if (metadata["xesam:artist"]) return metadata["xesam:artist"]
		if (typeof metadata["xesam:artist"] === "string") {
			return metadata["xesam:artist"]
		} else {
			return metadata["xesam:artist"].join(", ")
		}
	}

	property string albumArt: {
		return metadata
			? metadata["mpris:artUrl"] || ""
			: ""
	}

	// TODO: config
	property string displayContent: {
		if (!metadata) return "No media played"
		return artist + " - " + trackTitle
	}

	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    // Plasmoid.compactRepresentation: Flow {
    // 	id: mainContent

    // 	flow: Flow.LeftToRight
    // 	// Layout.minimumWidth: mainContent.width

    // 	Text {
	   //      text: displayContent
	   //      // effectiveHorizontalAlignment: Text.Align

	   //      color: PlasmaCore.Theme.textColor
	   //  	verticalAlignment: Text.AlignBottom
	   //      // anchors.right: parent.right
	   //      // anchors.bottom: parent.bottom
	   //      // anchors.fill: parent
	   //  }
    // }

    Plasmoid.compactRepresentation: Text {
        text: displayContent
        // effectiveHorizontalAlignment: Text.Align

        color: PlasmaCore.Theme.textColor
    	verticalAlignment: Text.AlignVCenter
        // anchors.right: parent.right
        // anchors.bottom: parent.bottom
        // anchors.fill: parent
    }
    

    PlasmaCore.DataSource {
    	id: mpris2Source
    	engine: "mpris2"
    	connectedSources: sources
    	// interval: 1000
    	readonly property var multiplexData: data["@multiplex"]
    }
}