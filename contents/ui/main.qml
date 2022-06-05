import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
// import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
	id: root

	// TODO: config
	// Plasmoid.switchWidth: PlasmaCore.Units.gridUnit * 10
	// Plasmoid.switchHeight: PlasmaCore.Units.gridUnit * 1
	// height: 10

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

    Plasmoid.compactRepresentation: Grid {
    	id: mainContent

    	// flow: Flow.LeftToRight
    	Layout.minimumWidth: 300
    	Layout.minimumHeight: 24

    	readonly property int buttonSize: root.isVertical ? width : height

        columns: root.isVertical ? 1 : 3
        rows: root.isVertical ? 3 : 1

        // Layout.minimumWidth: root.isVertical ? PlasmaCore.Units.iconSizes.small : ((height * 2) + spacer.width)
        // Layout.minimumHeight: root.isVertical ? ((width * 2) + spacer.height) : PlasmaCore.Units.iconSizes.small

    	Text {
	        text: displayContent
	        // effectiveHorizontalAlignment: Text.Align

	        color: PlasmaCore.Theme.textColor
	    verticalAlignment: Text.AlignVCenter
	        // anchors.right: parent.right
	        // anchors.bottom: parent.bottom
	        // anchors.fill: parent
	    }
    }

    PlasmaCore.DataSource {
    	id: mpris2Source
    	engine: "mpris2"
    	connectedSources: sources
    	// interval: 1000
    	readonly property var multiplexData: data["@multiplex"]
    }
}