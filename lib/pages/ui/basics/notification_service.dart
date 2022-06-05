import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotificatio() async {
    final IOSInitializationSettings iOSInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("appicon");
    final InitializationSettings initializationSettings =
        InitializationSettings(
            iOS: iOSInitializationSettings,
            android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  displayNotification({required String title, required String body}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      print("Notification payload: $payload");
    } else {
      print("Notification done");
    }
    Get.to(() => Container(
          color: Colors.white,
        ));
  }

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    Get.dialog(const Text("Welcome to Flutter"));
  }
}
