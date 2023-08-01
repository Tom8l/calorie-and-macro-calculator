import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import MacroBE 1.0



Window {
    id: root
    width: 800
    height: 600
    minimumWidth: 800
    minimumHeight: 600
    visible: true
    title: qsTr("Calorie & Macro Calculator")


    // This part is simply responsible for the tabs above, their clickability and names, but NOT the actual content in the tabs.
    TabBar {
        id: mainTabBar
        anchors {
            fill: parent
        }

        TabButton {
            text: "Calories"
        }

        TabButton {
            text: "Macros"

        }

        TabButton {
            text: "Next Steps..."
        }


    }

    // A StackLayout is used to actually attach content to specific tabs.
    StackLayout {
        id: mainLayout
        currentIndex: mainTabBar.currentIndex

        anchors {
            fill: parent
        }

        // Each tab has an Item component that encompasses ALL the content for that specific tab.
        Item {
            id: maintenanceCaloriesContent

            // This ButtonGroup is used to make sure you can only pick one of "Male" or "Female".
            ButtonGroup {
                id: sexButtons
                buttons: sexColumn.children
            }

            // Provides the blue question mark icon
            Image {
                id: maintenanceQuestionMark
                source: "qrc:/icons/icons/blue_qmark_icon.png"
                x: root.width - 35
                y: 48
                width: 25
                height: 25

                // Will open the help window for the Calories tab.
                MouseArea {
                    anchors.fill: parent

                    property QtObject window
                    onClicked: {
                        if (!window) {
                            window = Qt.createComponent("caloriesHelp.qml").createObject();
                        }
                        window.show();
                    }
                }
            }

            // The main, outer column for this tab
            Column {
                id: caloriesMainColumn

                width: root.width
                height: root.height

                topPadding: 60

                // Each row has its own Item component.
                // This is the first row with Sex, Age and Activity level.
                Item {
                    id: itemSexAgeActivity
                    width: parent.width
                    height: childrenRect.height

                    // This column contains everything related to the Sex field, i.e. the text, the buttons and the error text
                    Column {
                        id: sexColumn
                        spacing: 5

                        anchors {
                            left: parent.left
                            leftMargin: 40
                        }

                        Text {
                            text: "Sex"
                            font.pointSize: 10
                        }

                        RadioButton {
                            text: "Male"
                        }

                        RadioButton {
                            text: "Female"
                        }

                        Text {
                            id: caloriesSexError
                            text: "Please select your sex"
                            color: "red"
                            visible: false
                        }
                    }

                    // This column contains everything related to the Age field
                    Column {
                        id: ageColumn
                        spacing: 5

                        anchors {
                            horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: "Age"
                            font.pointSize: 10
                        }

                        // Contains a regex that makes sure only numbers and exactly one decimal point can be typed
                        TextField {
                            id: caloriesAgeInput
                            placeholderText: "Enter your age"
                            validator: RegExpValidator{regExp: /^\d*\.?\d*$/}
                            font.pointSize: 10
                        }

                        Text {
                            id: caloriesAgeError
                            text: "Please fill in your age"
                            color: "red"
                            visible: false
                        }
                    }

                    // Everything related to the Activity level field
                    Column {
                        id: activityColumn
                        spacing: 5

                        anchors {
                            right: parent.right
                            rightMargin: 40
                        }

                        Text {
                            text: "Activity level"
                            font.pointSize: 10
                        }

                        ComboBox {
                            id: activityLvlDropdown

                            model: ListModel {
                                id: activityLvls
                                ListElement {text: "Sedentary"}
                                ListElement {text: "Lightly active"}
                                ListElement {text: "Moderately active"}
                                ListElement {text: "Active"}
                                ListElement {text: "Very active"}
                            }
                        }
                    }
                }

                // This Item component is just a hacky way to set custom spacing between a column's children.
                Item {
                    width: 1
                    height: 25
                }

                // 2nd row with Weight, Height and Goal.
                Item {
                    id: itemWeightHeight
                    width: parent.width
                    height: childrenRect.height

                    // Weight field
                    Column {
                        id: weightColumn

                        spacing: 5
                        anchors {
                            left: parent.left
                            leftMargin: 40
                        }

                        Text {
                            text: "Weight (kg)"
                            font.pointSize: 10
                        }

                        TextField {
                            id: caloriesWeightInput
                            placeholderText: "Enter your weight (kg)"
                            validator: RegExpValidator{regExp: /^\d*\.?\d*$/}
                            font.pointSize: 10
                        }

                        Text {
                            id: caloriesWeightError
                            text: "Please fill in your weight"
                            color: "red"
                            visible: false
                        }
                    }

                    // Height field
                    Column {
                        id: heightColumn

                        spacing: 5
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: "Height (cm)"
                            font.pointSize: 10
                        }

                        TextField {
                            id: caloriesHeightInput
                            placeholderText: "Enter your height (cm)"
                            validator: RegExpValidator{regExp: /^\d*\.?\d*$/}
                            font.pointSize: 10
                        }

                        Text {
                            id: caloriesHeightError
                            text: "Please fill in your height"
                            color: "red"
                            visible: false
                        }


                    }

                    // Goal field
                    Column {
                        id: goalColumn

                        spacing: 5
                        anchors {
                            right: parent.right
                            rightMargin: 40
                        }

                        Text {
                            text: "Your goal"
                            font.pointSize: 10
                        }

                        ComboBox {
                            id: goalDropDown

                            model: ListModel {
                                id: goalItems
                                ListElement {text: "Fat loss"}
                                ListElement {text: "Muscle growth"}
                                ListElement {text: "Maintenance"}
                            }
                        }
                    }
                }

                // Another one of those spacing things. These appear a lot in this code.
                Item {
                    width: 1
                    height: 40
                }

                // Everything related to the Calculate button
                // Here's where the C++ backend, with the equations and calculations, is integrated
                Button {
                    id: maintenanceCalculateButton
                    text: "Calculate"
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }

                    onClicked: {

                        // Checks whether any of the fields are empty or not.
                        // If there are, empty fields will display their error text...
                        // ...while non-empty ones will hide their error text (if it was visible)
                        if (caloriesAgeInput.text.length * caloriesWeightInput.text.length * caloriesHeightInput.text.length == 0 || sexButtons.checkState == Qt.Unchecked) {

                            if (sexButtons.checkState == Qt.Unchecked) {
                                caloriesSexError.visible = true
                            }

                            else {
                                caloriesSexError.visible = false
                            }

                            if (caloriesAgeInput.text.length == 0) {
                                caloriesAgeError.visible = true
                            }

                            else {
                                caloriesAgeError.visible = false
                            }

                            if (caloriesWeightInput.text.length == 0) {
                                caloriesWeightError.visible = true
                            }

                            else {
                                caloriesWeightError.visible = false
                            }

                            if (caloriesHeightInput.text.length == 0) {
                                caloriesHeightError.visible = true
                            }

                            else {
                                caloriesHeightError.visible = false
                            }

                        }

                        // If every field is filled, do the calculation and display it in the "Calories (kcal" field.
                        // Also hide any error texts, if they are visible.
                        else {
                            calorieOutputField.text = Backend.calorieEquation(sexButtons.checkedButton.text, caloriesAgeInput.text, activityLvlDropdown.currentValue, caloriesWeightInput.text, caloriesHeightInput.text, goalDropDown.currentValue)
                            caloriesSexError.visible = false
                            caloriesAgeError.visible = false
                            caloriesWeightError.visible = false
                            caloriesHeightError.visible = false
                        }


                    }
                }

                // Everything related to the output field, i.e. the Calories field
                Item {
                    width: 1
                    height: 25
                }

                Text {
                    anchors {
                        left: parent.left
                        leftMargin: 40
                    }

                    text: "Your calorie intake (kcal)"
                    font.pointSize: 10
                }


                Item {
                    width: 1
                    height: 5
                }

                TextField {
                    id: calorieOutputField
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: 40
                        rightMargin: 40
                    }
                    font.pointSize: 14
                    readOnly: true
                }


            }


            // This text should stick to the bottom, so it can't be part of the main column.
            Text {
                id: macroMedscapecreditText
                text: "This uses the Mifflin-St Jeor Equation with <a href='https://reference.medscape.com/calculator/846/mifflin-st-jeor-equation'>Medscape</a> as reference together with guidelines from <a href='https://www.aworkoutroutine.com/how-many-calories-should-i-eat-a-day/'>AWorkoutRoutine</a>"
                onLinkActivated: Qt.openUrlExternally(link)

                anchors {
                    horizontalCenter: parent.horizontalCenter
                }

                y: root.height - 20
            }
        }




        // Beginning of the Macros tab.
        Item {
           id: macrosTabContent

           // For the blue question mark icon.
           Image {
               id: macroQuestionMark
               source: "qrc:/icons/icons/blue_qmark_icon.png"
               x: root.width - 35
               y: 48
               width: 25
               height: 25

               // Making the icon clickable, making it open a help window.
               MouseArea {
                   anchors.fill: parent

                   property QtObject window
                   onClicked: {
                       if (!window) {
                           window = Qt.createComponent("macroHelp.qml").createObject();
                       }
                       window.show();
                   }
               }
           }

           // Column containing everything related to inputs (i.e. text fields where the user needs to type something)
           Column {
               id: macroInputColumn
               spacing: 5

               width: root.width
               height: root.height

               topPadding: 70

               // Following 3 components make up the Calories input field
               Text {
                   id: kcalText
                   text: "Calorie intake (kcal)"
                   anchors {
                       left: parent.left
                       right: parent.right
                       leftMargin: 23
                       rightMargin: 23
                   }
                   font.pointSize: 10
               }


               TextField {
                   id: kcalTextField
                   anchors {
                       left: parent.left
                       right: parent.right
                       leftMargin: 20
                       rightMargin: 20
                   }
                   font.pointSize: 10
                   height: 30
                   placeholderText: "Enter your calorie intake (kcal)"
                   validator: RegExpValidator{regExp: /^\d*\.?\d*$/}
               }

               Text {
                   id: kcalTextError
                   anchors {
                        left: parent.left
                        leftMargin: 20
                   }
                   text: "Please enter your determined calorie intake"
                   color: "red"
                   visible: false
               }


               Item {
                   width: 1
                   height: 30
               }

               // Following 3 components make up the Weight field
               Text {
                   id: bwText
                   text: "Weight (kg)"
                   anchors {
                       left: parent.left
                       right: parent.right
                       leftMargin: 23
                       rightMargin: 23
                   }
                   font.pointSize: 10
               }

               TextField {
                   id: bwTextField
                   anchors {
                       left: parent.left
                       right: parent.right
                       leftMargin: 20
                       rightMargin: 20
                   }
                   font.pointSize: 10
                   height: 30
                   placeholderText: "Enter your weight (kg)"
                   validator: RegExpValidator{regExp: /^\d*\.?\d*$/}
               }

               Text {
                   id: bwTextError
                   anchors {
                        left: parent.left
                        leftMargin: 20
                   }
                   text: "Please enter your weight"
                   color: "red"
                   visible: false
               }
           }


            // Calculate button and also where the C++ backend is integrated
            Button {
               id: macroCalculateButton
               text: "Calculate"

               anchors {
                   horizontalCenter: kcalMacros.horizontalCenter
                   bottom: kcalMacros.top
                   bottomMargin: 30
               }

               onClicked: {

                   // Checks if any of the fields are empty or not
                   // If there are empty fields, turn the error texts visible...
                   // ...all while hiding error texts of non-empty fields
                   if (kcalTextField.text.length * bwTextField.text.length == 0) {

                       if (kcalTextField.text.length == 0) {
                           kcalTextError.visible = true
                       }

                       else {
                           kcalTextError.visible = false
                       }

                       if (bwTextField.text.length == 0) {
                           bwTextError.visible = true
                       }

                       else {
                           bwTextError.visible = false
                       }
                   }

                   else {

                       // Removing the error text messages
                       kcalTextError.visible = false
                       bwTextError.visible = false

                       // Calculating the macros and putting the results in each respective textbox
                       proteinOutput.text = Backend.proteinEquation(bwTextField.text)
                       fatOutput.text = Backend.fatEquation(kcalTextField.text)
                       carbOutput.text = Backend.carbEquation(kcalTextField.text, bwTextField.text)

                   }
               }

            }

            // Column containing all the output fields
            Column {
                id: kcalMacros
                spacing: 3

                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom

                    leftMargin: 20
                    rightMargin: 20
                    bottomMargin: 80
                }


                // Following 2 components are for the Protein output
                Text {
                    id: proteinOutputText
                    text: "Protein (g)"
                }

                TextField {
                    id: proteinOutput
                    width: root.width - parent.anchors.leftMargin*2
                    readOnly: true
                    font.pointSize: 14
                }

                Item {
                    width: 1
                    height: 5
                }


                // Following 2 components are for the Fat output
                Text {
                    id: fatOutputText
                    text: "Fat (g)"
                }

                TextField {
                    id: fatOutput
                    width: root.width - parent.anchors.leftMargin*2
                    readOnly: true
                    font.pointSize: 14
                }

                Item {
                    width: 1
                    height: 5
                }


                // Following 2 components are for the Carbs output
                Text {
                    id: carbsOutputText
                    text: "Carbs (g)"
                }

                TextField {
                    id: carbOutput
                    width: root.width - parent.anchors.leftMargin*2
                    readOnly: true
                    font.pointSize: 14
                }
            }



           // Text linking to where the calculation guidelines came from
           Text {
               id: macroAWRcreditText
               text: "Numbers calculated according to guidelines on <a href='https://www.aworkoutroutine.com/how-to-calculate-macros/'>AWorkoutRoutine</a>"
               onLinkActivated: Qt.openUrlExternally(link)

               anchors {
                   horizontalCenter: parent.horizontalCenter
               }

               y: root.height - 20
           }
        }



        // Everything related to the "Next Steps" tab.
        Item {
            id: miscTabContent

            Column {
                id: miscMainColumn

                width: root.width
                height: root.height
                topPadding: 45
                leftPadding: 10
                rightPadding: 10
                spacing: 5


                // Intro text
                Text {
                    id: miscIntroHeader

                    text: "YOUR NEXT STEPS..."
                    font.bold: true
                    font.pointSize: 14

                }

                Text {
                    id: miscIntroText

                    text: "Calculating your calorie intake and macros is great and everything, but will be useless if you don't actually put it into action.<br>Furthermore, tracking your weight improperly (or not all) can derail your progress easily.<br><br>This tab will cover these two areas as much as this dinky little window of text is capable of doing, and will likely refer to external material.<br><br> (There was going to be something about resistance training as well, being a <i>requirement</i> for muscle growth and all, but I'm running out of space to type words on so I'll just link <a href='https://www.aworkoutroutine.com/beginner-workouts/'>this</a> and move on)."
                    font.pointSize: 10

                    width: root.width - 10
                    wrapMode: "WordWrap"

                    onLinkActivated: Qt.openUrlExternally(link)
                }

                Item {
                    width: 1
                    height: 10
                }


                // Motivation & habits text
                Text {
                    id: miscHabitsHeader

                    text: "MOTIVATION, HABITS & CONSISTENCY"
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: miscHabitsText

                    text: "To begin with: <b>forget</b> anything about <u>getting or staying motivated</u>. Why? Because motivation is <i>unreliable</i>. It comes around, knocking on your door to give you a warm embrace, only to disappear when you need it the most.<br><br> Instead, focus on <u>building habits, <b>one at a time</b></u>. Maybe you'll begin with just hitting your protein goal, regardless of calories or any of the other macros. Once you get used to doing so for a good 2 weeks or so, the next habit to establish could be to ensure your calorie intake is where it should be.<br><br> This <a href='https://www.aworkoutroutine.com/motivation/'>article</a> by AWorkoutRoutine explains everything in more detail."
                    font.pointSize: 10

                    width: root.width - 10
                    wrapMode: "WordWrap"

                    onLinkActivated: Qt.openUrlExternally(link)
                }


                Item {
                    width: 1
                    height: 10
                }



                // Weight tracking text
                Text {
                    id: miscTrackingHeader

                    text: "TRACKING YOUR WEIGHT"
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: miscTrackingText

                    text: "The steps of <b>proper weight tracking</b> is as follows:
                          <ul>
                              <li>Weigh yourself every day, ideally in the morning (after finishing any business in the bathroom).</li>
                              <li>Record your weight down somewhere, but <u>IGNORE DAILY DIFFERENCES IN WEIGHT</u>. They are <i>meaningless</i>.</li>
                              <li>Instead, compare <u>each week's average</u> to each other.</li>
                              <li>Only after you have 4+ weeks of averages, ask yourself if your calorie intake needs adjusting or not.</li>
                          </ul><br> For fat loss, aim to lose 0.3-1% of your total weight per <u>week</u>.<br>
                                For muscle growth, aim to gain 0.5-1 kg per <u>month</u> if male, and 0.25-0.5 kg per <u>month</u> if female. Comparing monthly averages can be more useful here.
                                <br><br>Lastly, please don't stress yourself too much over how your weight grows/shrinks over time. In practice, it's impossible to be gaining EXACTLY x kilograms per week/month, and sometimes your tracking will look slower/faster than it actually is."
                    font.pointSize: 10

                    width: root.width - 10
                    wrapMode: "WordWrap"
                }
            }
        }
    }
}
