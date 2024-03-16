import QtQuick 2.15
import QtQuick.Layouts 1.1
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.private.mpris as Mpris

PlasmoidItem {
    id: root

    property var metadata: mpris2Model.currentPlayer ? mpris2Model.currentPlayer : undefined

    property string trackTitle: {
        if (!metadata) return "no metadata title found"
        if (metadata.track) return metadata.track
        // if (metadata["xesam:url"]) return metadata["xesam:url"].toString()
        return ""
    }

    property string artist: {
        if (!metadata) return "no metadata artist found"
        if (metadata.artist) return metadata.artist
        return ""
    }

    property string albumArt: {
        return metadata
            ? metadata.artUrl || ""
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
        if (!metadata) return plasmoid.configuration.noMediaString
        if (trackTitle == "" && artist == "no metadata artist found") return plasmoid.configuration.noArtistString
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

    Mpris.Mpris2Model {
        id: mpris2Model
        onDataChanged: {
            updateLayoutSize()
        }
        onCurrentPlayerChanged: {
            updateLayoutSize()
        }
    }

    function updateLayoutSize() {
        Layout.minimumWidth = oneLineLayout.contentWidth
        Layout.minimumHeight = oneLineLayout.contentHeight
    }

    preferredRepresentation: fullRepresentation
    fullRepresentation: OneLineLayout {
        id: oneLineLayout
        Layout.minimumWidth: oneLineLayout.contentWidth
        Layout.minimumHeight: oneLineLayout.contentHeight
    }
}
