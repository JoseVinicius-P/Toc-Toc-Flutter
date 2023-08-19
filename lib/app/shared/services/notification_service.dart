import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as timezone;
import 'package:timezone/timezone.dart' as timezone;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService{
  static final _notification = FlutterLocalNotificationsPlugin();

  static void init(){
    initLocalNotifications();
    initMessagingListeners();
    initTimezone();
    loadSound();
  }

  static void loadSound() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('sound') == null){
      DocumentReference docRef = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid);
      DocumentSnapshot snapshot = await docRef.get();
      if(snapshot.get('sound') != null){
        prefs.setString('sound', snapshot.get('sound'));
      }else{
        prefs.setString('sound', 'TocToc');
      }
    }
  }

  static void initTimezone() async {
    timezone.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    timezone.setLocalLocation(timezone.getLocation(timeZoneName));
  }

  static void initLocalNotifications() {
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (details){
        Modular.to.navigate("/call/", arguments: {
          'data': details.payload
        });
      },
    );
  }

  static void initMessagingListeners(){
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Modular.to.navigate('/call/', arguments: {
      'data': jsonEncode(message.data),
      });
    });

    FirebaseMessaging.onMessage.listen((event) async {
      initTimezone();
      await NotificationService.fullScreenNotification(event, 'onMessage');
    });

    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    //O firebase estava interceptando a chamada e enviando uma notificação padrão, o Cancel cancela todas e impede que a notificação automatica seja exibida
    await _notification.cancelAll();
    initTimezone();
    NotificationService.fullScreenNotification(message, 'backgroundMessageHandler');
  }

   static fullScreenNotification(RemoteMessage message, String origem) async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String sound = prefs.getString('sound')!.replaceAll('.mp3', '');
      await _notification.zonedSchedule(
          0,
          message.notification!.title,
          message.notification!.body,
          timezone.TZDateTime.now(timezone.local).add(const Duration(milliseconds: 50)),
          NotificationDetails(
              android: AndroidNotificationDetails(
                'Visitas - $sound',
                'Visitas - $sound',
                channelDescription: 'Notificação para visitas dos seus amigos com som $sound',
                priority: Priority.high,
                importance: Importance.high,
                fullScreenIntent: true,
                sound: RawResourceAndroidNotificationSound(sound.toLowerCase())
              )
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          payload: jsonEncode(message.data),
      );
    }catch(e, s){
      debugPrint("ERRO: $e, $s");
    }
  }

  static Future<bool> didNotificationLaunchApp() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails = await _notification.getNotificationAppLaunchDetails();
    return notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
  }
}