import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

Text {
    property int fontSize: {
    return (plasmoid.configuration.shouldUseDefaultThemeFontSize)
        ? PlasmaCore.Theme.defaultFont.pixelSize
        : plasmoid.configuration.configuredFontSize
    }

    text: oneLineTextContent
    color: PlasmaCore.Theme.textColor
    // horizontalAlignment: Text.AlignRight
    verticalAlignment: Text.AlignVCenter
    font.pixelSize: fontSize
}
