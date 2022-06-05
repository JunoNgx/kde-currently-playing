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
	// Layout.preferredWidth: 640 * units.devicePixelRatio
	// Layout.preferredHeight: 480 * units.devicePixelRatio


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
	property string textContent: {
		if (!metadata) return "No media played"
		return artist + " - " + trackTitle
	}

	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    // Plasmoid.compactRepresentation: Flow {
    // 	id: contentComponent

    // 	flow: Flow.LeftToRight
    // 	anchors.fill: parent
    // 	// Layout.minimumWidth: mainContent.width

    // 	// Text {
    // 	// 	id: textContentComponent
	   //  //     text: textContent
	   //  //     // effectiveHorizontalAlignment: Text.Align

	   //  //     color: PlasmaCore.Theme.textColor
	   //  // 	verticalAlignment: Text.AlignVCenter
	   //  // 	wrapMode: Text.WordWrap
	   //  //     // anchors.right: parent.right
	   //  //     // anchors.bottom: parent.bottom
	   //  //     // anchors.fill: parent
	   //  // }

	   //  // Text {
	   //  // 	text: textContentComponent.contentWidth
	   //  // }
    // }

    Plasmoid.compactRepresentation: Text {
    	id: textContentComponent
        text: textContent
        color: PlasmaCore.Theme.textColor
    	verticalAlignment: Text.AlignVCenter
    }
    

    PlasmaCore.DataSource {
    	id: mpris2Source
    	engine: "mpris2"
    	connectedSources: sources
    	// interval: 1000
    	readonly property var multiplexData: data["@multiplex"]

    	onDataChanged: {
    		width = displayContent.contentWidth
    	}
    }
}