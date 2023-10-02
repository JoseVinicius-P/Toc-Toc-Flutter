import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/shared/services/notification_service.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    //Initialize Logging
    await FlutterLogs.initLogs(
        logLevelsEnabled: [
            LogLevel.INFO,
            LogLevel.WARNING,
            LogLevel.ERROR,
            LogLevel.SEVERE
        ],
        timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
        directoryStructure: DirectoryStructure.FOR_DATE,
        logTypesEnabled: ["device","network","errors"],
        logFileExtension: LogFileExtension.LOG,
        logsWriteDirectoryName: "LogsToctoc",
        logsExportDirectoryName: "LogsToctoc/Exported",
        debugFileOperations: true,
        isDebuggable: true);

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );

    NotificationService.init();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
        runApp(
          ResponsiveApp(builder: (context) => ModularApp(module: AppModule(), child: AppWidget())), // Wrap your app
        );
    });

}
