#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qSetMessagePattern("[%{time yyyy-MM-dd hh:mm:ss.zzz}][%{type}][%{function}:%{line}] - %{message}");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/qmlApp/Main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
