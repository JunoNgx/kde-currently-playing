import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
  
    property alias cfg_shouldDisplayTitleOnly: shouldDisplayTitleOnly.checked
    property alias cfg_shouldDisplayTitleFirst: shouldDisplayTitleFirst.checked
    property alias cfg_shouldAddLeadingWhitespaceToSeparator: shouldAddLeadingWhitespaceToSeparator.checked
    property alias cfg_shouldAddTrailingWhitespaceToSeparator: shouldAddTrailingWhitespaceToSeparator.checked
    property alias cfg_characterLimit: characterLimit.text
    property alias cfg_separatorString: separatorString.text
    property alias cfg_shouldUseDefaultThemeFontSize: shouldUseDefaultThemeFontSize.checked
    property alias cfg_configuredFontSize: configuredFontSize.text

    CheckBox {
        id: shouldDisplayTitleOnly
        Kirigami.FormData.label: i18n("Display options:")
        text: i18n("Display title only")
    }

    CheckBox {
        id: shouldDisplayTitleFirst
        text: i18n("Display title first")
    }

    CheckBox {
        id: shouldAddLeadingWhitespaceToSeparator
        text: i18n("Add leading whitespace to separator string")
    }

    CheckBox {
        id: shouldAddTrailingWhitespaceToSeparator
        text: i18n("Add trailing whitespace to separator string")
    }

    TextField {
        id: characterLimit
        Kirigami.FormData.label: i18n("Character Limit:")
        placeholderText: i18n("")
        validator: IntValidator {bottom: 0; top: 9999}
    }

    TextField {
        id: separatorString
        Kirigami.FormData.label: i18n("Separator string:")
        placeholderText: i18n("")
    }

    CheckBox {
        id: shouldUseDefaultThemeFontSize
        text: i18n("Ignore the setting below and use theme default size")
    }

    TextField {
        id: configuredFontSize
        Kirigami.FormData.label: i18n("Custom font size:")
        placeholderText: i18n("")
        validator: IntValidator {bottom: 0; top: 9999}
    }
}