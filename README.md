# Calorie & Macro Calculator
A calculator that works out your calorie and macro intake, given your goal.

Made using Qt 5.15.

WINDOWS ONLY AT THE MOMENT


## Download

Click [HERE](https://github.com/Tom8l/calorie-and-macro-calculator/releases/download/v1.0.0/calorie-and-macro-calculator-v1.0.0.zip) to download the latest version.

Once downloaded, extract the files and open **macro_calc.exe** to use the calculator.

You can find other versions by clicking **Release** on the right-hand side of the repository page.



## Calculating Calorie Intake

You'll be greeted by this screen when you first open the calculator:

![macro_calc__2023-08-01__17;11;21](https://github.com/Tom8l/calorie-and-macro-calculator/assets/78360008/d27592c4-d77c-4447-8977-4b50f354779f)


On this tab, you'll be calculating your calorie intake.

**All you need to do is fill in every input field and press the *Calculate* button, and your estimated (goal) calorie intake will appear in the "Your calories (kcal)" field.**

As for how the calculations are done under the hood:

The calculator uses the Mifflin-St Jeor equation, which so far has been found to be the most accurate equation for predicting your resting metabolic rate (RMR).

Your estimaed RMR is then multiplied with activity level scale factors sourced from [Medscape](https://reference.medscape.com/calculator/846/mifflin-st-jeor-equation) to determine how many calories you burn every day.

Finally, with guidelines from [AWorkoutRoutine](https://www.aworkoutroutine.com/how-many-calories-should-i-eat-a-day/), your (goal) calorie intake is determined.

More details and explanations can be found by clicking the blue question mark icon located top-right of the screen.



## Calculating Macros

To calculate your macros, click on the **Macros** tab:

![macro_calc__2023-08-01__17;11;24](https://github.com/Tom8l/calorie-and-macro-calculator/assets/78360008/92940abf-e33e-4fb9-9f74-8a85f7dec36a)

Using your calorie intake and body weight, this calculator will determine your protein, fat and carb intake, using guidelines from [AWorkoutRoutine](https://www.aworkoutroutine.com/how-to-calculate-macros/).

**The calorie intake you calculated in the Calories tab should be put in the first field** (if you determined your calorie intake through some other way, you'll still type it in the first field).

And just to clarify, the weight you enter here is the same as the weight in the **Calories** tab.




## Miscellaneous

The **Next Steps** tab contains information regarding what you should do after you're done determining your calorie and macro intake. More specifically, it briefly covers the following areas:
- How to ensure you actually stay on track with your diet
- How to track your weight **properly**





