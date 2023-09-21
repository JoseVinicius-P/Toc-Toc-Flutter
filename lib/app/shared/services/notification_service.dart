import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timezone/data/latest_all.dart' as timezone;
import 'package:timezone/timezone.dart' as timezone;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:toctoc/app/shared/services/call_reply_service.dart';
import 'package:toctoc/firebase_options.dart';

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
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        var data = jsonDecode(notificationResponse.payload!);
        if (notificationResponse.notificationResponseType == NotificationResponseType.selectedNotification) {
          Modular.to.pushNamed("/call/", arguments: {
            'data': jsonEncode(data),
            'receivingCall' : true,
            'isAppInBackground' : data['isAppInBackground'],
          });
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    createDeafaultChannel();
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(NotificationResponse notificationResponse) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if(notificationResponse.notificationResponseType == NotificationResponseType.selectedNotificationAction){
      var data = jsonDecode(notificationResponse.payload!);
      var callReply = CallReplyService();
      if (notificationResponse.actionId == 'nao_estou_em_casa') {
        callReply.sendReply("Não Estou em casa!", data['callId']);
      }else if(notificationResponse.actionId == 'estou_indo'){
        callReply.sendReply("Estou indo", data['callId']);
      }
    }
  }

  static void initMessagingListeners(){
    FirebaseMessaging.onMessage.listen((event) async {
      FlutterLogs.logInfo("Notification", "forground", "Entrou no onMessage");
      initTimezone();
      await NotificationService.fullScreenNotification(event, false);
    });

    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  @pragma('vm:entry-point') //Esta linha corrige o bug que impedia que notificações fossem abertar em segundo plano
  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    //O firebase estava interceptando a chamada e enviando uma notificação padrão, o Cancel cancela todas e impede que a notificação automatica seja exibida
    FlutterLogs.logInfo("Notification", "background", "Entrou no backgroundMessageHandler");
    try{
      await notification.cancelAll();
      initTimezone();
      NotificationService.fullScreenNotification(message, true);
    }catch(e, s){
      FlutterLogs.logError("Notification", "background", e.toString());
      FlutterLogs.logError("Notification", "background", s.toString());
    }
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
                icon: '@mipmap/launcher_icon',
                actions: <AndroidNotificationAction>[
                  AndroidNotificationAction('nao_estou_em_casa', 'Ñ estou em casa', showsUserInterface: false),
                  AndroidNotificationAction('estou_indo', 'Estou indo'),
                  AndroidNotificationAction('ignorar', 'Ignorar'),
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