import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/shared/services/notification_service.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void onMessage() {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((event) async {
        await NotificationService.pushNotification(event);
    });
}

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );

    NotificationService.init();
    onMessage();

    runApp(
        ResponsiveApp(builder: (context) => ModularApp(module: AppModule(), child: AppWidget())),
    );
}
