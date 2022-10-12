// coverage:ignore-file
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:mvc_bolierplate_getx/core/reponsive/SizeConfig.dart';
import 'package:mvc_bolierplate_getx/core/universal_widgets/no_internet_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api_service/dio_service.dart';
import 'package:dio/dio.dart' as DIO;
import '../constants/string_constants.dart';

abstract class Utility {
  /// instance of DIO
  static var dio = DioUtil().getInstance();

  // coverage:ignore-start
  static final Random _random = Random();

  /// print logs
  static void printDLog(String message) {}

  /// Print info log.
  ///
  /// [message] : The message which needed to be print.
  static void printILog(dynamic message) {
    Logger().i('${StringConstants.appName}: $message');
  }

  /// Print info log.
  ///
  /// [message] : The message which needed to be print.
  static void printLog(dynamic message) {
    Logger().log(Level.info, message);
  }

  /// Print error log.
  ///
  /// [message] : The message which needed to be print.
  static void printELog(String message) {
    Logger().e('${StringConstants.appName}: $message');
  }

  /// Returns a list of booleans by validating [].
  ///
  /// for at least one upper case, at least one digit,
  /// at least one special character and and at least 6 characters long
  /// return [List<bool>] for each case.
  /// Validation logic
  /// r'^
  ///   (?=.*[A-Z])                   // should contain at least one upper case
  ///   (?=.*?[0-9])                  // should contain at least one digit
  ///   (?=.*?[!@#\\/^%?$&*~]).{8,}   // should contain at least one Special character
  /// $
  // static List<bool> passwordValidator(String password) {
  //   var validationStatus = <bool>[false, false, false, false, false];
  //   validationStatus[0] = password.length >= 8;
  //   validationStatus[1] = RegExp(r'(?=.*[A-Z])').hasMatch(password);
  //   validationStatus[2] = RegExp(r'(?=.*[a-z])').hasMatch(password);
  //   validationStatus[3] = RegExp(r'(?=.*?[0-9])').hasMatch(password);
  //   validationStatus[4] = RegExp(r'(?=.*?[!@#\\/^%?$&*~])').hasMatch(password);
  //   return validationStatus;
  // }

  /// Returns a error String by validating password.
  ///
  /// for at least one upper case, at least one digit,
  /// at least one special character and and at least 6 characters long
  /// return [List<bool>] for each case.
  /// Validation logic
  /// r'^
  ///   (?=.*[A-Z])             // should contain at least one upper case
  ///   (?=.*?[0-9])            // should contain at least one digit
  ///  (?=.*?[!@#\$&*~]).{8,}   // should contain at least one Special character
  /// $
  static String? validatePassword(String value) {
    if (value.trim().isNotEmpty) {
      if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        if (value.contains(RegExp(r'[A-Z]'))) {
          if (value.contains(RegExp(r'[0-9]'))) {
            if (value.length < 6) {
              return 'shouldBe6Characters'.tr;
            } else {
              return null;
            }
          } else {
            return 'shouldHaveOneDigit'.tr;
          }
        } else {
          return 'shouldHaveOneUppercaseLetter'.tr;
        }
      } else {
        return 'shouldHaveOneSpecialCharacter'.tr;
      }
    } else {
      return 'passwordRequired'.tr;
    }
  }

  /// Returns true if the internet connection is available.
  static Future<bool> isNetworkAvailable() async =>
      await InternetConnectionChecker().hasConnection;

  /// Print the details of the [response].
  static void printResponseDetails(Response? response) {
    if (response != null) {
      var isOkay = response.isOk;
      var statusCode = response.statusCode;
      var statusText = response.statusText;
      var method = response.request?.method ?? '';
      var path = response.request?.url.path ?? '';
      var query = response.request?.url.queryParameters ?? '';
      if (isOkay) {
        printILog(
            'Path: $path, Method: $method, Status Text: $statusText, Status Code: $statusCode, Query $query');
      } else {
        printELog(
            'Path: $path, Method: $method, Status Text: $statusText, Status Code: $statusCode, Query $query');
      }
    }
  }

  /// get formated [DateTime] eg. 12 Jul 2021
  static String getDayAbbrMonthYear(DateTime dateTime) =>
      '${DateFormat.d().format(dateTime)} ${DateFormat.yMMM().format(dateTime)}';

  /// get formated [DateTime] eg. 12
  static String getOnlyDate(DateTime dateTime) {
    try {
      return DateFormat('dd').format(dateTime);
    } catch (_) {
      return '';
    }
  }

  /// get formated [DateTime] eg. 12 Sep
  static String getDateAndMonth(DateTime dateTime) =>
      DateFormat('dd MMM').format(dateTime);

  static String getWeekDay(DateTime dateTime) =>
      DateFormat.EEEE().format(dateTime);

  /// Calculates number of weeks for a given year as per https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year
  static int _numOfWeeks(int year) {
    var dec28 = DateTime(year, 12, 28);
    var dayOfDec28 = int.parse(DateFormat('D').format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  // Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
  static int weekNumber(DateTime date) {
    var dayOfYear = int.parse(DateFormat('D').format(date));
    var woy = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = _numOfWeeks(date.year - 1);
    } else if (woy > _numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }

  /// Show no internet dialog if there is no
  /// internet available.
  static void showNoInternetDialog() {
    closeDialog();
    Get.dialog<void>(
      const NoInternetWidget(),
      barrierDismissible: false,
    );
  }

  /// Show loader
  static void showLoader() async {
    await Get.dialog(
      const Center(
        child: SizedBox(
          height: 60,
          width: 60,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Close loader
  static void closeLoader() {
    closeDialog();
  }

  /// Get current location in string.
  // static Future<LocationDataLocal> getCurrentLocation() async {
  //   var position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //   var locationDetails =
  //       await getAddressThroughLatLng(position.latitude, position.longitude);
  //   return getLocationData(
  //     locationDetails,
  //     position.latitude,
  //     position.longitude,
  //   );
  // }

  /// Generate session token for
  /// google place api to reduce billing.
  ///
  /// [Check this link](https://developers.google.com/places/web-service/session-tokens).
  static String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final special = 8 + _random.nextInt(4);
    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  static String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  static int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  static String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');

  /// Get all location details from the address object.
  ///
  /// [locationDetails] : the location details got from geocoder.
  // static LocationDataLocal getLocationData(
  //   Placemark? locationDetails,
  //   double lat,
  //   double long,
  // ) =>
  //     LocationDataLocal(
  //       placeName: locationDetails?.name == 'Unnamed Road'
  //           ? locationDetails?.subLocality ?? ''
  //           : locationDetails?.name ?? '',
  //       addressLine1: locationDetails?.subLocality ?? '',
  //       addressLine2: locationDetails?.administrativeArea ?? '',
  //       area: locationDetails?.locality == ''
  //           ? locationDetails?.subLocality ?? ''
  //           : locationDetails?.locality ?? '',
  //       city: locationDetails?.subAdministrativeArea ?? '',
  //       postalCode: locationDetails?.postalCode ?? '',
  //       country: locationDetails?.country ?? '',
  //       latitude: lat,
  //       longitude: long,
  //     );

  /// Get the location name by giving the lat long.
  ///
  /// [latitude] : latitude of the location.
  /// [longitude] : longitude of the location.
  // static Future<Placemark?> getAddressThroughLatLng(
  //     double? latitude, double? longitude) async {
  //   if (latitude != null && longitude != null) {
  //     var addresses = await GeocodingPlatform.instance.placemarkFromCoordinates(
  //       latitude,
  //       longitude,
  //     );
  //     printDLog(addresses[0].toString());
  //     return addresses[0];
  //   }
  //   return null;
  // }

  /// URL Launcher
  static void launchURL(String url) async => await canLaunchUrl(Uri.parse(url))
      ? launchURL(url)
      : showDialog(message: 'Could not open $url');

  /// Show error dialog from response model
  static void showInfoDialog(
      {required String message, bool isSuccess = false}) async {
    await Get.dialog(
      CupertinoAlertDialog(
        title: Text(isSuccess ? 'SUCCESS' : 'ERROR'),
        content: Text(
          message,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: Get.back,
            isDefaultAction: true,
            child: const Text(
              'Okay',
            ),
          ),
        ],
      ),
    );
  }

  /// Show a loading progress indicator
  /// on top of the screen.
  static void showLoadingDialog() {
    closeDialog();
    Get.dialog<void>(
      WillPopScope(
        onWillPop: () async => false,
        child: const Center(child: CircularProgressIndicator()),
      ),
      barrierDismissible: false,
    );
  }

  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  /// Show info dialog
  static void showDialog({
    required String message,
  }) async {
    await Get.dialog(
      CupertinoAlertDialog(
        title: const Text('Info'),
        content: Text(
          message,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: Get.back,
            child: const Text(
              'Okay',
            ),
          ),
        ],
      ),
    );
  }

  /// Show alert dialog
  static void showAlertDialog({
    String? message,
    String? title,
    Function()? onPress,
  }) async {
    await Get.dialog(
      CupertinoAlertDialog(
        title: Text('$title'),
        content: Text('$message'),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onPress,
            child: const Text('Yes'),
          ),
          const CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: closeDialog,
            child: Text('No'),
          )
        ],
      ),
    );
  }

  /// Close any open snack bar.
  static void closeSnackBar() {
    ScaffoldMessenger.of(Get.overlayContext!).removeCurrentSnackBar();
  }

  /// Close any open bottom sheet.
  static void closeBottomSheet() {
    if (Get.isBottomSheetOpen ?? false) Get.back<void>();
  }

  /// Close any open snackbar
  static void closeSnackbar() {
    if (Get.isSnackbarOpen) Get.back<void>();
  }

  /// Show a message to the user.
  ///
  /// [message] : Message you need to show to the user.
  /// [messageType] : Type of the message for different background color.
  /// [onTap] : An event for onTap.
  /// [actionName] : The name for the action.

  static void showMessage(String? message, MessageType messageType,
      Function()? onTap, String actionName) {
    if (message == null || message.isEmpty) return;
    closeDialog();
    closeSnackbar();
    var backgroundColor = Colors.black;
    switch (messageType) {
      case MessageType.error:
        backgroundColor = Colors.red;
        break;
      case MessageType.information:
        backgroundColor = Colors.black.withOpacity(0.3);
        break;
      case MessageType.success:
        backgroundColor = Colors.green;
        break;
      default:
        backgroundColor = Colors.black;
        break;
    }
    Future.delayed(
      const Duration(seconds: 0),
      () {
        Get.rawSnackbar(
          messageText: Text(
            message,
          ),
          mainButton: TextButton(
            onPressed: onTap ?? Get.back,
            child: Text(
              actionName,
            ),
          ),
          backgroundColor: backgroundColor,
          margin: EdgeInsets.all(15 * SizeConfig.heightMultiplier!),
          borderRadius: 15 * SizeConfig.heightMultiplier!,
          snackStyle: SnackStyle.FLOATING,
        );
      },
    );
  }

  static Future<String> uploadMultipartImages({
    List<File>? profilePhoto,
  }) async {
    var formData = DIO.FormData();

    if (profilePhoto != null) {
      for (var file in profilePhoto) {
        formData.files.addAll([
          MapEntry(
              'profilePhoto',
              await DIO.MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last)),
        ]);
      }
    }
    dio!.options.headers["language"] = "1";
    dio!.options.headers['Authorization'] = "AUTH_TOKEN";
    final response = await dio!.post('API_URL', data: formData);
    final responseData = jsonDecode(response.toString());
    return responseData["response"]["data"];
  }

  static Future<String?> getIp() async {
    var response = await dio!.get('https://api.ipify.org?format=json');
    return response.data['ip'];
  }
}

enum MessageType {
  error,
  information,
  success,
}
