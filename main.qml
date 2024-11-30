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


    // This part is simply responsible for the tabs at the top, their apperance, clickability and name, but NOT the actual content in the tabs.
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
                    hoverEnabled: true
                    cursorShape: this.containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor

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
                            font.family: "Tahoma"
                        }

                        RadioButton {
                            id: maleRadioButton

                            text: "Male"
                            font.pointSize: 9   // Default pointSize is 8.25 and that screws up the RadioButton text for some reason
                            font.family: "Tahoma"
                        }

                        RadioButton {
                            text: "Female"
                            font.pointSize: 9   // Same as above
                            font.family: "Tahoma"
                        }

                        Text {
                            id: caloriesSexError
                            text: "Please select your sex"
                            color: "red"
                            font.family: "Tahoma"
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
                            font.family: "Tahoma"
                        }

                        // Contains a regex that makes sure only numbers and exactly one decimal point can be typed
                        TextField {
                            id: caloriesAgeInput
                            placeholderText: "Enter your age"
                            validator: RegExpValidator{regExp: /^\d*\.?\d*$/}
                            font.pointSize: 10
                            font.family: "Tahoma"
                            selectByMouse: true
                        }

                        Text {
                            id: caloriesAgeError
                            text: "Please fill in your age"
                            color: "red"
                            font.family: "Tahoma"
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
                            font.family: "Tahoma"
                        }

                        ComboBox {
                            id: activityLvlDropdown
                            font.family: "Tahoma"

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
                            font.family: "Tahoma"
                        }

                        TextField {
                            id: caloriesWeightInput
                            placeholderText: "Enter your weight (kg)"
                            validator: RegExpValidator{regExp: /^\d*\.?\d*$/}
                            font.pointSize: 10
                            font.family: "Tahoma"
                            selectByMouse: true
                        }

                        Text {
                            id: caloriesWeightError
                            text: "Please fill in your weight"
                            color: "red"
                            font.family: "Tahoma"
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
                            font.family: "Tahoma"
                        }

                        TextField {
                            id: caloriesHeightInput
                            placeholderText: "Enter your height (cm)"
                            validator: RegExpValidator{regExp: /^\d*\.?\d*$/}
                            font.pointSize: 10
                            font.family: "Tahoma"
                            selectByMouse: true
                        }

                        Text {
                            id: caloriesHeightError
                            text: "Please fill in your height"
                            color: "red"
                            font.family: "Tahoma"
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
                            font.family: "Tahoma"
                        }

                        ComboBox {
                            id: goalDropDown
                            font.family: "Tahoma"

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
                    font.family: "Tahoma"
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }

                    // Changing the cursor to pointing hand when hovering over the button
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: this.containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                        onPressed: {
                            mouse.accepted = false;
                        }
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

                        // If every field is filled, do the calculation and display it in the "Calories (kcal" field).
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
                    font.family: "Tahoma"
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
                    font.family: "Tahoma"
                    readOnly: true
                    selectByMouse: true
                }
            }


            // This text should stick to the bottom, so it can't be part of the main column.
            Text {
                id: caloriesCreditText
                text: "This uses the Mifflin-St Jeor Equation with <a href='https://reference.medscape.com/calculator/846/mifflin-st-jeor-equation'>Medscape</a> as reference together with guidelines from <a href='https://www.aworkoutroutine.com/how-many-calories-should-i-eat-a-day/'>AWorkoutRoutine</a>"
                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
                font.family: "Tahoma"

                anchors {
                    horizontalCenter: parent.horizontalCenter
                }

                y: root.height - 20

                MouseArea {
                    anchors.fill: parent
                    cursorShape: caloriesCreditText.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onPressed: {
                        mouse.accepted = false;
                    }
                }
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
                   hoverEnabled: true
                   cursorShape: this.containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor

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
                   font.family: "Tahoma"
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
                   font.family: "Tahoma"
                   height: 30
                   placeholderText: "Enter your calorie intake (kcal)"
                   validator: RegExpValidator{regExp: /^\d*\.?\d*$/}
                   selectByMouse: true
               }

               Text {
                   id: kcalTextError
                   anchors {
                        left: parent.left
                        leftMargin: 20
                   }
                   text: "Please enter your determined calorie intake"
                   color: "red"
                   font.family: "Tahoma"
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
                   font.family: "Tahoma"
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
                   font.family: "Tahoma"
                   height: 30
                   placeholderText: "Enter your weight (kg)"
                   validator: RegExpValidator{regExp: /^\d*\.?\d*$/}
                   selectByMouse: true
               }

               Text {
                   id: bwTextError
                   anchors {
                        left: parent.left
                        leftMargin: 20
                   }
                   text: "Please enter your weight"
                   color: "red"
                   font.family: "Tahoma"
                   visible: false
               }
           }


            // Calculate button and also where the C++ backend is integrated
            Button {
               id: macroCalculateButton
               text: "Calculate"
               font.family: "Tahoma"

               anchors {
                   horizontalCenter: kcalMacros.horizontalCenter
                   bottom: kcalMacros.top
                   bottomMargin: 30
               }

               MouseArea {
                   anchors.fill: parent
                   hoverEnabled: true
                   cursorShape: this.containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                   onPressed: {
                       mouse.accepted = false;
                   }
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
                    font.family: "Tahoma"
                }

                TextField {
                    id: proteinOutput
                    width: root.width - parent.anchors.leftMargin*2
                    readOnly: true
                    font.pointSize: 14
                    font.family: "Tahoma"
                    selectByMouse: true
                }

                Item {
                    width: 1
                    height: 5
                }


                // Following 2 components are for the Fat output
                Text {
                    id: fatOutputText
                    text: "Fat (g)"
                    font.family: "Tahoma"
                }

                TextField {
                    id: fatOutput
                    width: root.width - parent.anchors.leftMargin*2
                    readOnly: true
                    font.pointSize: 14
                    selectByMouse: true
                    font.family: "Tahoma"
                }

                Item {
                    width: 1
                    height: 5
                }


                // Following 2 components are for the Carbs output
                Text {
                    id: carbsOutputText
                    text: "Carbs (g)"
                    font.family: "Tahoma"
                }

                TextField {
                    id: carbOutput
                    width: root.width - parent.anchors.leftMargin*2
                    readOnly: true
                    font.pointSize: 14
                    font.family: "Tahoma"
                    selectByMouse: true
                }
            }



           // Text linking to where the calculation guidelines came from
           Text {
               id: macroCreditText
               text: "Numbers calculated according to guidelines on <a href='https://www.aworkoutroutine.com/how-to-calculate-macros/'>AWorkoutRoutine</a>"
               onLinkActivated: Qt.openUrlExternally(link)
               font.family: "Tahoma"

               anchors {
                   horizontalCenter: parent.horizontalCenter
               }

               y: root.height - 20

               MouseArea {
                   anchors.fill: parent
                   cursorShape: macroCreditText.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                   onPressed: {
                       mouse.accepted = false;
                   }
               }
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
                    font.family: "Tahoma"

                }

                Text {
                    id: miscIntroText

                    text: "You’ve just calculated your (estimated!) calorie intake and macros. Maybe there was some discomfort involved with entering your weight, or finding out what it was in the first place.

But now you’re ready to get the ball rolling and watch as the fat melts off your body. As your muscles grow like a nest of rabbits left to their own. Right?

Well I hope so, because unfortunately (maybe fortunately actually), nobody can MAKE YOU do the things you need to do to get that envious body. Hell, you might be in a situation much tougher than I’ve ever dealt with.

For example, I’d have a hard time helping a single mom in her 40s, living paycheck to paycheck ON TOP of wanting to be healthier, beyond throwing generic advice at her. A 20-something guy may be easier, but still, any advice is a shot in the dark beyond generics.

So I’ll simply leave you with a couple things that can be pretty damn important and then hope for the best."
                    font.pointSize: 10
                    font.family: "Tahoma"

                    width: root.width - 15
                    wrapMode: "WordWrap"

                    onLinkActivated: Qt.openUrlExternally(link)

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: miscIntroText.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                        onPressed: {
                            mouse.accepted = false;
                        }
                    }
                }

                Item {
                    width: 1
                    height: 10
                }


                // Motivation & habits text
                Text {
                    id: miscTrackingHeader

                    text: "TRACKING PROGRESS"
                    font.bold: true
                    font.pointSize: 12
                    font.family: "Tahoma"
                }

                Text {
                    id: miscTrackingText

                    text: "You might’ve noticed the “estimated!” part above. Well, I put it there for a good reason. See, the calorie intake you got is just an estimate. It may work perfectly for reaching your goals... or not at all. <br><br> That’s why you likely want a way of knowing if it works, or if you need to adjust the intake. <br><br> <a href='https://www.aworkoutroutine.com/weighing-yourself/'>Here's a simple article on weight tracking</a> (still requires more than goldfish attention span though) <br><br> <a href='https://bodyrecomposition.com/fat-loss/bmi-weighing-frequency#Should_You_WeightMeasure_Frequently'>And here's a more detailed one</a>

"
                    font.pointSize: 10
                    font.family: "Tahoma"

                    width: root.width - 10
                    wrapMode: "WordWrap"

                    onLinkActivated: Qt.openUrlExternally(link)

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: miscTrackingText.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                        onPressed: {
                            mouse.accepted = false;
                        }
                    }
                }


                Item {
                    width: 1
                    height: 5
                }



                // Weight tracking text
                Text {
                    id: miscHabitsHeader

                    text: "HABITS, MOTIVATION, AND ACTUALLY DOING THE WORK"
                    font.bold: true
                    font.pointSize: 12
                    font.family: "Tahoma"
                }

                Text {
                    id: miscHabitsText

                    text: "Chances are, you already know at least an iota about habits if you’re reading this. Maybe you even own a copy of <i>Atomic Habits</i> (and in that case I think you'll already know the stuff I'll show you) <br><br> Either way, here’s an article on motivation and habits, geared toward fitness goals: <a href='https://www.aworkoutroutine.com/motivation/'>click on me</a> <br>-----<br> And that’s all I have. I wish you the utmost of luck as you work toward that dream body of yours, or maybe just a healthier you.
"
                    font.pointSize: 10
                    font.family: "Tahoma"

                    width: root.width - 10
                    wrapMode: "WordWrap"
                }
            }
        }
    }
}
