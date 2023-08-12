import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as timezone;
import 'package:timezone/timezone.dart' as timezone;

class NotificationService{
  static final _notification = FlutterLocalNotificationsPlugin();

  static void init() {
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
  }

  static pushNotification(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'Visitas',
      'Visitas',
      channelDescription: 'Notificação para visitas dos seus amigos',
      priority: Priority.high,
      importance: Importance.max,
      fullScreenIntent: true,
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