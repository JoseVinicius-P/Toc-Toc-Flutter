import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/shared/services/notification_service.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );

    NotificationService.init();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
        runApp(
            DevicePreview(
                enabled: !kReleaseMode,
                builder: (context) => ResponsiveApp(builder: (context) => ModularApp(module: AppModule(), child: AppWidget())), // Wrap your app
            ),
        );
    });

}
