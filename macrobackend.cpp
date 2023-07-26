#include "macrobackend.h"

MacroBackend::MacroBackend(QObject *parent)
    : QObject{parent}
{
}


// Input is a QString representing Activity level which is converted to the appropriate enumerator value
ActivityLvl MacroBackend::stringToActivity(QString string) {
    if (string == "Sedentary") {
        return SEDENTARY;
    }

    else if (string == "Lightly active") {
        return LIGHTLY_ACTIVE;
    }

    else if (string == "Moderately active") {
        return MODERATELY_ACTIVE;
    }

    else if (string == "Active") {
        return ACTIVE;
    }

    else if (string == "Very active") {
        return VERY_ACTIVE;
    }

    else {
        throw std::invalid_argument("How did this happen?!");
    }
}

// Input is QString representing Goal which is converted to the appropriate enumerator value
Goal MacroBackend::stringToGoal(QString string) {
    if (string == "Fat loss") {
        return FAT_LOSS;
    }

    else if (string == "Muscle growth") {
        return MUSCLE_GROWTH;
    }

    else if (string == "Maintenance") {
        return MAINTENANCE;
    }

    else {
        throw std::invalid_argument("WTF?!");
    }
}

// The Mifflin-St Jeor Equation...
// ...together with an Activity level multiplier
// This calculates an individual's calorie intake for maintenance
double MacroBackend::mifflin(QString sex, int age, QString activitylvl, double weight, double height) {

    double activityMultiplier;
    ActivityLvl activityEnum = MacroBackend::stringToActivity(activitylvl);

    switch (activityEnum) {
    case SEDENTARY:
        activityMultiplier = 1.2;
        break;

    case LIGHTLY_ACTIVE:
        activityMultiplier = 1.375;
        break;

    case MODERATELY_ACTIVE:
        activityMultiplier = 1.55;
        break;

    case ACTIVE:
        activityMultiplier = 1.725;
        break;

    case VERY_ACTIVE:
        activityMultiplier = 1.9;
        break;
    }


    if (sex == "Male") {
        return ((10*weight) + (6.25*height) - (5*age) + 5) * activityMultiplier;
    }

    else if (sex == "Female")  {
        return ((10*weight) + (6.25*height) - (5*age) - 161) * activityMultiplier;
    }

    else {
        throw std::invalid_argument("Please just click one of the two radio buttons");
    }

}



// Given maintenance calories, goal and the individual's sex...
// ...calculate their goal calorie intake
double MacroBackend::goalCalories(double maintenance, QString goal, QString sex){

    Goal goalEnum = MacroBackend::stringToGoal(goal);


    switch(goalEnum) {

    // If goal is to lose weight
    case 0:

        return maintenance * (1 - cuttingMultiplier);
        break;

    // If goal is to build muscle
    case 1:

        if (sex == "Male") {
            return maintenance + bulkingAdditionMale;
        }

        else if (sex == "Female") {
            return maintenance + bulkingAdditionFemale;
        }

        else {
            throw std::invalid_argument("Seriously just click one of the buttons");
        }

        break;

    // If goal is to maintain
    case 2:
        return maintenance;
        break;

    default:
        std::cout << "This is not supposed to happen.";
        return 0;
    }
}

// Putting both mifflin() and goalCalories() together to immediately calculate goal calorie intake
double MacroBackend::calorieEquation(QString sex, int age, QString activitylvl, double weight, double height, QString goal) {
    double calorieIntake;
    calorieIntake = goalCalories(mifflin(sex, age, activitylvl, weight, height), goal, sex);
    return round(calorieIntake);
}

// Equation for calculating protein
double MacroBackend::proteinEquation(double weight) {
    return round(weight * proteinMultiplier);
}

// Equation for calculating fat
double MacroBackend::fatEquation(double calories) {
    return round(calories * fatMultiplier / 9);     // Divided by 9 because 1 g of fat = 9 kcal
}

// Equation for calculating carbs
double MacroBackend::carbEquation(double calories, double weight) {
    return round((calories - proteinEquation(weight) * 4 - fatEquation(calories) * 9) / 4);
}



