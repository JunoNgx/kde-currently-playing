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

    property string separatorString: {
        let separatorStr = ""

        if (plasmoid.configuration.shouldAddLeadingWhitespaceToSeparator)
            separatorStr += " "

        separatorStr += plasmoid.configuration.separatorString

        if (plasmoid.configuration.shouldAddTrailingWhitespaceToSeparator)
            separatorStr += " "

        return separatorStr
    }

    property string oneLineTextContent: {
        if (!metadata) return "No media"
        if (!trackTitle && !artist) return ""

        if (plasmoid.configuration.shouldDisplayTitleOnly)
            return trackTitle

        let content
        if (plasmoid.configuration.shouldDisplayTitleFirst) {
            content = trackTitle
                + separatorString
                + artist
        } else {
            content = artist
                + separatorString
                + trackTitle
        }

        if (content.length > plasmoid.configuration.characterLimit)
            content = content.slice(0, plasmoid.configuration.characterLimit)

        return content
    }


    property var twoLineLayoutWidth: {
        return Math.max(
            artistContentComponent.contentWidth,
            trackContentComponent.contentWidth
        )
    }

    property var twoLineLayoutHeight: {
        return artistContentComponent.contentHeight
            + trackContentComponent.contentHeight
    }

    PlasmaCore.DataSource {
        id: mpris2Source

        engine: "mpris2"
        connectedSources: sources
        // interval: 1000
        readonly property var multiplexData: data["@multiplex"]

        onNewData: {
            updateLayoutSize()
        }

        onSourceAdded: {
            updateLayoutSize()
        }

        onSourceRemoved: {
            updateLayoutSize()
        }
    }

    function updateLayoutSize() {
        Layout.minimumWidth = oneLineLayout.contentWidth
        Layout.minimumHeight = oneLineLayout.contentHeight
    }

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.fullRepresentation: OneLineLayout {
        id: oneLineLayout
        Layout.minimumWidth: oneLineLayout.contentWidth
        Layout.minimumHeight: oneLineLayout.contentHeight
    }
    
    // Plasmoid.fullRepresentation: Text {
    //     id: oneLineLayout

    //     Layout.minimumWidth: oneLineLayout.contentWidth
    //     Layout.minimumHeight: oneLineLayout.contentHeight

    //     text: oneLineTextContent
    //     color: PlasmaCore.Theme.textColor
    //     horizontalAlignment: Text.AlignRight
    //     verticalAlignment: Text.AlignVCenter
    // }

    // ColumnLayout {
    //     id: fullLayout

    //     Layout.minimumWidth: twoLineLayoutWidth
    //     Layout.minimumHeight: twoLineLayoutHeight
    //     Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

    //     Text {
    //         id: artistContentComponent

    //         text: artist
    //         color: PlasmaCore.Theme.textColor
    //         horizontalAlignment: Text.AlignRight
    //         verticalAlignment: Text.AlignVCenter

    //     }

    //     Text {
    //         id: trackContentComponent

    //         text: trackTitle
    //         color: PlasmaCore.Theme.textColor
    //         verticalAlignment: Text.AlignVCenter
    //     }

    //     Text {
    //         id: debugContentComponent

    //         text: twoLineLayoutWidth
    //         color: PlasmaCore.Theme.textColor
    //         verticalAlignment: Text.AlignVCenter
    //     }
    // }

    // Text {
    //     id: oneLineLayout

    //     Layout.minimumWidth: oneLineLayout.contentWidth
    //     Layout.minimumHeight: oneLineLayout.contentHeight

    //     text: oneLineTextContent
    //     color: PlasmaCore.Theme.textColor
    //     horizontalAlignment: Text.AlignRight
    //     verticalAlignment: Text.AlignVCenter
    // }

    // Text {
    //     id: notPlayedLayout

    //     text: "No media played"
    //     color: PlasmaCore.Theme.textColor
    //     verticalAlignment: Text.AlignVCenter
    // }
}