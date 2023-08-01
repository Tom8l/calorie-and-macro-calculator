import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: root
    width: 600
    height: 400
    minimumWidth: 600
    minimumHeight: 400
    visible: true
    title: qsTr("Calories Tab Help")


    // This column contains all text
    Column {

        spacing: 15
        anchors {
            fill: parent
            margins: 5
        }

        Text {
            id: caloriesHelpHeader

            text: "CALORIES TAB HELP"
            font.pointSize: 12
            font.bold: true
        }


        Text {

            text: "On this tab, you'll calculate your <b>calorie intake</b>, that is, how many calories you'll eat."

            width: root.width - 10
            wrapMode: "WordWrap"

            font.pointSize: 10
        }

        Text {
            text: "This is all done with respect to <b>your current goal</b>:
            <ul>
                <li>Fat loss - if you want to lose weight</li>
                <li>Muscle growth - if you want to build muscle (this entails gaining weight)</li>
                <li>Maintenance (or recomp) - if you simply want to maintain your current weight</li>
            </ul>"

            width: root.width - 10
            wrapMode: "WordWrap"

            font.pointSize: 10

        }


        Text {
            text: "Remember that <b>this is just an <u>estimate</u>!</b> This means... <br>
        1. Don't get too hung up on the \"right\" activity level. Just pick one that seems half fitting. Because... <br>
        2. ...it's HIGHLY recommended that you track your <b>body weight <i><u>properly</i></u></b>, to see whether the amount of calories need adjusting or not. <br><br>
Tracking body weight is explained in the <b>Next Steps...</b> tab. <br>"

            width: root.width - 10
            wrapMode: "WordWrap"
            font.pointSize: 10

        }

        Text {
            text: "Once you've calculated your <b>calorie intake</b> (or already done so through some other method), go to the <b>Macros</b> tab."

            width: root.width - 10
            wrapMode: "WordWrap"
            font.pointSize: 10
        }
    }
}
