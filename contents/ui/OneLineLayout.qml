import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Text {
    text: oneLineTextContent
    color: PlasmaCore.Theme.textColor
    horizontalAlignment: Text.AlignRight
    verticalAlignment: Text.AlignVCenter
}