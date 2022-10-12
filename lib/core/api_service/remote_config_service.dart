import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';

class RemoteConfigService {
  static FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  static Future<void> onForceFetched(FirebaseRemoteConfig remoteConfig) async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ));
      await remoteConfig.fetchAndActivate();
    } on PlatformException catch (e) {
      log(e.message.toString());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future fetchAndActivate() async {
    await remoteConfig.fetch();
    await remoteConfig.fetchAndActivate();
  }
}
