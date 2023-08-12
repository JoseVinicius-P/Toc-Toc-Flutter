import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timezone/data/latest_all.dart' as timezone;
import 'package:timezone/timezone.dart' as timezone;

class NotificationService{
  static final _notification = FlutterLocalNotificationsPlugin();

  static void init(){
    initLocalNotifications();
    initMessagingListeners();
  }

  static void initLocalNotifications() {
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
  }

  static void initMessagingListeners(){
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Modular.to.navigate('/call/');
    });

    FirebaseMessaging.onMessage.listen((event) async {
      await NotificationService.pushNotification(event);
    });

    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  static pushNotification(RemoteMessage message) async {
    const int publicFlag = 1;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Visitas',
      'Visitas',
      channelDescription: 'Notificação para visitas dos seus amigos',
      priority: Priority.high,
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('dingdong'),
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _notification.show(
        1253,
        message.notification!.title,
        message.notification!.body,
        platformChannelSpecifics
    );

  }

  static Future<bool> didNotificationLaunchApp() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails = await _notification.getNotificationAppLaunchDetails();
    return notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
  }
}