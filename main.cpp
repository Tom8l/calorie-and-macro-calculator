#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "macrobackend.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    // The following two lines of code are needed to use the C++ backend in QML
    // Basically creates an instance of the MacroBackend class and makes that instance available for use in QML
    QScopedPointer<MacroBackend> backend(new MacroBackend);
    qmlRegisterSingletonInstance<MacroBackend>("MacroBE", 1, 0, "Backend", backend.get());

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
