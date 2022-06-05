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

    property string textContent: {
        if (!metadata) return "No media played"
        return artist + " - " + trackTitle
    }

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    Plasmoid.compactRepresentation: RowLayout {
        id: mainContentComponent

        Layout.minimumWidth: textContentComponent.contentWidth
        Layout.minimumHeight: textContentComponent.contentHeight

        Text {
            id: textContentComponent

            text: textContent
            color: PlasmaCore.Theme.textColor
            verticalAlignment: Text.AlignVCenter
        }

        // Text {
        //  text: textContentComponent.contentWidth
        //  color: PlasmaCore.Theme.textColor
        // }
    }

    PlasmaCore.DataSource {
        id: mpris2Source

        engine: "mpris2"
        connectedSources: sources
        // interval: 1000
        readonly property var multiplexData: data["@multiplex"]

        onDataChanged: {
            Layout.minimumWidth = textContentComponent.contentWidth
            Layout.minimumHeight = textContentComponent.contentHeight
        }
    }
}