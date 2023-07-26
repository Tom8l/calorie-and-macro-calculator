import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: root
    width: 600
    height: 400
    minimumWidth: 600
    minimumHeight: 400
    visible: true
    title: qsTr("Macro Tab Help")


    // This column contains all text
    Column {

        spacing: 15
        anchors {
            fill: parent
            margins: 5
        }

        Text {
            id: macrosHelpHeader

            text: "MACROS TAB HELP"
            font.pointSize: 12
            font.bold: true
        }

        Text {

            text: "On this tab, you'll calculate your <b>macros</b>, that is, your protein, fat and carb intake."

            width: root.width - 10
            wrapMode: "WordWrap"

            font.pointSize: 10
        }

        Text {

            text: "You should have already calculated your calorie intake in the <b>Calories</b> tab (or determined it through some other way) as it's needed in this section. If you haven't done so, go back to the <b>Calories</b> tab."

            width: root.width - 10
            wrapMode: "WordWrap"

            font.pointSize: 10
        }

        Text {
            text: "Once you've calculated your macros, go to the <b>Next Steps...</b> tab."

            width: root.width - 10
            wrapMode: "WordWrap"

            font.pointSize: 10

        }
    }
}
