import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc_bolierplate_getx/my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/log_in/view/login_screen.dart';

initializeNotification() {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            importance: NotificationImportance.Max,
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
}

void selectNotification(String? payload) async {
  if (payload != null) {
    log('notification payload: $payload');
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            importance: NotificationImportance.Max,
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
}

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDRBN0vbSjnxewXDzAhbzVLUmVzCmGraJ0',
          appId: '1:71597666309:android:164d12dbe5948b10b42c6c',
          messagingSenderId: '71597666309',
          projectId: 'mvcboilerplate-d4ce4'),
    );
    await initializeNotification();
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission();
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('AccessToken');

    var token = await FirebaseMessaging.instance.getToken();
    if (accessToken != null) {
      // LogInService.RegisterDeviceToken(token.toString(), deviceId);
      log("fcm token$token");
    }

    FirebaseMessaging.instance.getAPNSToken().then((value) {
      log("$value APN Token");
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    AwesomeNotifications()
        .actionStream
        .listen((ReceivedNotification notification) async {
      //TODO : On clicking the notification
    });

    FirebaseMessaging.onMessage.listen((message) async {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            displayOnForeground: true,
            displayOnBackground: true,
            channelKey: 'basic_channel',
            id: 10,
            title: message.notification!.title.toString(),
            wakeUpScreen: true,
            category: NotificationCategory.Reminder,
            autoDismissible: false,
            payload: {'data': jsonEncode(message.data)},
            body: message.notification!.body.toString()),
      );
    });

    FirebaseMessaging.instance.getInitialMessage().then((initialMessage) async {
      if (initialMessage != null) {
        //TODO: Get notifications after waking up from termination state
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      //TODO: Get notifications from suspended state
    });

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(MyApp(
      // translations: GetTranslations.loadTranslations(),
      child: accessToken == null ? LoginScreen() : LoginScreen(),
    ));
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

void registerFcmToken() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> deviceData = <String, dynamic>{};
  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;
  if (Platform.isAndroid == true) {
    androidInfo = await deviceInfoPlugin.androidInfo;
  } else {
    iosInfo = await deviceInfoPlugin.iosInfo;
  }
  String deviceId = Platform.isAndroid
      ? androidInfo!.version.sdkInt.toString()
      : iosInfo!.identifierForVendor.toString();

  log('Running on ${deviceData['device']}');
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('AccessToken');
  var token = await FirebaseMessaging.instance.getToken();
  if (accessToken != null) {
    // LogInService.RegisterDeviceToken(token.toString(), deviceId);
    log("fcm token$token");
  }
}
