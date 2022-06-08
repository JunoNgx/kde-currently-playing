import QtQuick 2.0
import QtQml 2.2

import org.kde.plasma.configuration 2.0
import org.kde.plasma.calendar 2.0 as PlasmaCalendar

ConfigModel {
    id: configModel

    ConfigCategory {
        name: i18n("General")
        icon: "configure"
        source: "configGeneral.qml"
    }
}