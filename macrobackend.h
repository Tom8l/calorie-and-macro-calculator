#ifndef MACROBACKEND_H
#define MACROBACKEND_H

#include <QObject>
#include <iostream>
#include <stdexcept>


// Enumerator for Activity level field
enum ActivityLvl {
    SEDENTARY,
    LIGHTLY_ACTIVE,
    MODERATELY_ACTIVE,
    ACTIVE,
    VERY_ACTIVE
};

// Enumerator for the Goal field
enum Goal {
    FAT_LOSS,
    MUSCLE_GROWTH,
    MAINTENANCE
};



class MacroBackend : public QObject
{
    Q_OBJECT


public:
    explicit MacroBackend(QObject *parent = nullptr);

    Q_INVOKABLE double mifflin(QString sex, int age, QString activitylvl, double weight, double height);

    Q_INVOKABLE double goalCalories(double maintenance, QString goal, QString sex);

    Q_INVOKABLE double calorieEquation(QString sex, int age, QString activitylvl, double weight, double height, QString goal);

    Q_INVOKABLE double proteinEquation(double weight);

    Q_INVOKABLE double fatEquation(double calories);

    Q_INVOKABLE double carbEquation(double calories, double weight);


private:

    // Useful numbers
    double kgTolbs = 2.20462262185; // In other words, this number is 1 kg in lbs

    // Goal related multipliers
    double cuttingMultiplier = 0.2;
    double bulkingAdditionMale = 200;
    double bulkingAdditionFemale = 100;

    // Macro multipliers
    double proteinMultiplier = kgTolbs;
    double fatMultiplier = 0.25;

    // String-to-enum conversions
    ActivityLvl stringToActivity(QString string);
    Goal stringToGoal(QString string);




signals:

};

#endif // MACROBACKEND_H
