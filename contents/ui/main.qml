import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root

    property var metadata: mpris2Source.multiplexData
        ? mpris2Source.multiplexData.Metadata
        : undefined

    property string trackTitle: {
        if (!metadata) return "no metadata title found"
        if (metadata["xesam:title"]) return metadata["xesam:title"]
        // if (metadata["xesam:url"]) return metadata["xesam:url"].toString()
        return ""
    }

    property string artist: {
        if (!metadata) return "no metadata artist found"
        if (metadata["xesam:artist"]) return metadata["xesam:artist"]
        if (typeof metadata["xesam:artist"] === "string") {
            return metadata["xesam:artist"]
        } else {
            return metadata["xesam:artist"].join(", ")
        }
        return ""
    }

    property string albumArt: {
        return metadata
            ? metadata["mpris:artUrl"] || ""
            : ""
    }

    property string textContent: {
        if (!metadata) return "No media played"
        if (!trackTitle && !artist) return ""
        return artist + " - " + trackTitle
    }

    property real getWidth: {
        return Math.max(
            artistContentComponent.contentWidth,
            trackContentComponent.contentWidth
        )
    }

    property real getHeight: {
        return artistContentComponent.contentHeight
            + trackContentComponent.contentHeight
    }

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    Plasmoid.compactRepresentation: fullLayout


    ColumnLayout {
        id: fullLayout

        Layout.minimumWidth: textContentComponent.contentWidth
        Layout.minimumHeight: textContentComponent.contentHeight

        Text {
            id: artistContentComponent

            text: artist
            color: PlasmaCore.Theme.textColor
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: trackContentComponent

            text: trackTitle
            color: PlasmaCore.Theme.textColor
            verticalAlignment: Text.AlignVCenter
        }
    }

    // Text {
    //     id: notPlayedLayout

    //     text: textContent
    //     color: PlasmaCore.Theme.textColor
    //     verticalAlignment: Text.AlignVCenter
    // }

    PlasmaCore.DataSource {
        id: mpris2Source

        engine: "mpris2"
        connectedSources: sources
        // interval: 1000
        readonly property var multiplexData: data["@multiplex"]

        onSourceAdded: {
            updateLayoutSize()
        }

        onSourceRemoved: {
            updateLayoutSize()
        }
    }

    function updateLayoutSize() {
        Layout.minimumWidth = getWidth
        Layout.minimumHeight = getHeight
    }

    function updateSourceData() {
        // root.sourceData = 
    }
}