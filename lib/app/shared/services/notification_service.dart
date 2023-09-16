import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timezone/data/latest_all.dart' as timezone;
import 'package:timezone/timezone.dart' as timezone;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService{
  static final notification = FlutterLocalNotificationsPlugin();
  static Timer? timer;
  static int notificationDurationSeconds = 0;

  static void init(){
    initLocalNotifications();
    initMessagingListeners();
    initTimezone();
  }

  static void initTimezone() async {
    timezone.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    timezone.setLocalLocation(timezone.getLocation(timeZoneName));
  }

  static void initLocalNotifications() {
    notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        var data = jsonDecode(notificationResponse.payload!);
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            Modular.to.pushNamed("/call/", arguments: {
              'data': jsonEncode(data),
              'receivingCall' : true,
              'isAppInBackground' : data['isAppInBackground'],
            });
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == 'nao_estou_em_casa') {
              data['autoReply'] = "Não Estou em casa!";
              Modular.to.pushNamed("/call/", arguments: {
                'data': jsonEncode(data),
                'receivingCall' : true,
                'isAppInBackground' : data['isAppInBackground'],
              });
            }else if(notificationResponse.actionId == 'estou_indo'){
              data['autoReply'] = "Estou indo";
              Modular.to.pushNamed("/call/", arguments: {
                'data': jsonEncode(data),
                'receivingCall' : true,
                'isAppInBackground' : data['isAppInBackground'],
              });
            }
            break;
        }
      },
    );
    createDeafaultChannel();
  }

  static void initMessagingListeners(){
    FirebaseMessaging.onMessage.listen((event) async {
      initTimezone();
      await NotificationService.fullScreenNotification(event, false);
    });

    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    //O firebase estava interceptando a chamada e enviando uma notificação padrão, o Cancel cancela todas e impede que a notificação automatica seja exibida
    await notification.cancelAll();
    initTimezone();
    NotificationService.fullScreenNotification(message, true);
  }

  static countDurationSecondsNotification(){
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) async {
        notificationDurationSeconds++;
        if(notificationDurationSeconds >= 30){
          timer!.cancel();
          notificationDurationSeconds = 0;
          await notification.cancelAll();
        }
    });
  }

  static stopNotificationDurationSecondsCount(){
    if(timer != null){
      timer!.cancel();
    }
  }

  static createDeafaultChannel() async {

    AndroidNotificationChannel androidNotificationChannel =
    const AndroidNotificationChannel(
      'Visitas',
      'Visitas',
      description: 'Notificação para visitas dos seus amigos',
      playSound: false,
    );

    final List<AndroidNotificationChannel>? channels =
    await notification
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!
        .getNotificationChannels();

    if(channels == null){
      await notification
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidNotificationChannel);
    }else if(channels.isEmpty || !channels.contains(androidNotificationChannel)){
      await notification
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidNotificationChannel);
    }
  }

   static fullScreenNotification(RemoteMessage message, bool isAppInBackground) async {
    notificationDurationSeconds = 0;
    try{
      String sound = (message.data['sound'] as String).replaceAll('.mp3', '');
      message.data.putIfAbsent('isAppInBackground', () => isAppInBackground);

      await notification.zonedSchedule(
          0,
          message.notification!.title,
          message.notification!.body,
          timezone.TZDateTime.now(timezone.local).add(const Duration(seconds: 1)),
          NotificationDetails(
              android: AndroidNotificationDetails(
                'Visitas - $sound',
                'Visitas - $sound',
                channelDescription: 'Notificação para visitas dos seus amigos com o som "$sound"',
                priority: Priority.high,
                importance: Importance.max,
                fullScreenIntent: true,
                ongoing: true,
                autoCancel: false,
                sound: RawResourceAndroidNotificationSound(sound.toLowerCase()),
                actions: <AndroidNotificationAction>[
                  AndroidNotificationAction('nao_estou_em_casa', 'Ñ estou em casa', showsUserInterface: true),
                  AndroidNotificationAction('estou_indo', 'Estou indo', showsUserInterface: true,),
                  AndroidNotificationAction('ignorar', 'Ignorar', showsUserInterface: false),
                ],
              )
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          payload: jsonEncode(message.data),
      );
      countDurationSecondsNotification();
    }catch(e, s){
      debugPrint("ERRO: $e, $s");
    }
  }

  static Future<bool> didNotificationLaunchApp() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails = await notification.getNotificationAppLaunchDetails();
    return notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
  }

  static Future<bool?>? areNotificationsEnable(){
    return notification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled();
  }

  static void requestNotificationPermission(){
    notification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  }
}