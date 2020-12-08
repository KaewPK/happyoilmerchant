import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:happyoilmerchant/Model/mol_DailyMachine.dart';
import 'package:happyoilmerchant/Model/mol_Machine.dart';
import 'package:happyoilmerchant/Model/mol_SelectMachineOilPrice.dart';
import 'package:happyoilmerchant/Model/mol_ShowMachine.dart';
import 'package:happyoilmerchant/Model/mol_ShowMachineRemain.dart';
import 'package:happyoilmerchant/UI/shared/api.dart';

FirebaseMessaging firebaseMessaging = FirebaseMessaging();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Const {
  static String username;
  static String sumValue;
  static String _title;
  static String _body;
  static List<ShowMachine> showMachine = List<ShowMachine>();
  static List<ShowMachineRemain> showMachineRemain = List<ShowMachineRemain>();
  static List<LocationMachine> locationMachine = List<LocationMachine>();
  static List<ShowDailyMachine> showDailyMachine = List<ShowDailyMachine>();
  static List<SelectMachineOilPrice> selectMachineOilPrice =
      List<SelectMachineOilPrice>();

  // Notifivcation Firebase
  static void initFirebaseMessaging() {
    showNotification();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _title = message["notification"]["title"];
        _body = message["notification"]["body"];
        _showNotificationWithDefaultSound();
      },
      onBackgroundMessage:
          Platform.isIOS ? null : Const.myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    firebaseMessaging.getToken().then((firebaseToken) {
      assert(firebaseToken != null);
      print("firebaseToken: $firebaseToken");
      Api.apiNotiStock(firebaseToken);
      Api.apiNotiBalance(firebaseToken);
      Api.apiNotiOilOrderComplete(firebaseToken);
    });
  }

  // show notification
  static void showNotification() {
    var initializationSettingsAndroid = AndroidInitializationSettings('icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelect);
  }

  // show notification
  static Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      _title,
      _body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  // show notification
  static Future<String> onSelect(String data) async {
    print("onSelectNotification $data");
  }

  // Firebase Message
  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }
    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
  }
}
