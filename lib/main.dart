import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvc_bolierplate_getx/feature/home/view/home.dart';
import 'package:mvc_bolierplate_getx/my_app.dart';

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