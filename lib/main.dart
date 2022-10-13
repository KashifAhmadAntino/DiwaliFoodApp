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
import 'package:mvc_bolierplate_getx/feature/home/view/home.dart';
import 'package:mvc_bolierplate_getx/my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/log_in/view/login_screen.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(const MyApp(
      // translations: GetTranslations.loadTranslations(),
      child: HomePage(),
    ));
  }, (error, stackTrace) {});
}
