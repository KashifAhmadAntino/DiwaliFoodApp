import 'dart:convert';

import '../api_service/remote_config_service.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  Map<String, String>? en;
  final Map<String, String>? es;

  AppTranslations({this.en, this.es});

  static AppTranslations fromJson(dynamic json) {
    return AppTranslations(
      en: Map<String, String>.from(json["en_US"]),
      es: Map<String, String>.from(json["es_ES"]),
    );
  }

  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": en!,
        "es_ES": es!,
      };
}

class GetTranslations {
  static AppTranslations loadTranslations() {
    return AppTranslations.fromJson(
        jsonDecode(RemoteConfigService.remoteConfig.getString('localization')));
  }
}
