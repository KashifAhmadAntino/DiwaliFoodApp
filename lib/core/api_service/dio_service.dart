import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../constants/image_path.dart';

class DioUtil {
  Dio? _instance;
//method for getting dio instance
  Dio? getInstance() {
    _instance ??= createDioInstance();
    return _instance;
  }

  Dio createDioInstance() {
    var dio = Dio();

    // adding interceptor
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options); //modify your request
    }, onResponse: (response, handler) {
      // ignore: unnecessary_null_comparison
      if (response != null) {
        return handler.next(response);
      } else {
        return;
      }
    }, onError: (DioError e, handler) async {
      if (e.response != null) {
        if (e.response!.statusCode == 403) {
          // dio.interceptors.requestLock.lock();
          // dio.interceptors.responseLock.lock();
          // RequestOptions requestOptions = e.requestOptions;
          // await LogInService.updateToken();
          // final SharedPreferences prefs = await SharedPreferences.getInstance();
          // var accessToken = prefs.getString('AccessToken').toString();
          // final opts = new Options(method: requestOptions.method);
          // dio.options.headers["language"] = "1";
          // dio.options.headers["Accept"] = "*/*";
          // dio.options.headers['Authorization'] = accessToken;
          // final response = await dio.request(requestOptions.path,
          //     options: opts,
          //     cancelToken: requestOptions.cancelToken,
          //     onReceiveProgress: requestOptions.onReceiveProgress,
          //     data: requestOptions.data,
          //     queryParameters: requestOptions.queryParameters);
          // ignore: unnecessary_null_comparison
          // if (response != null) {
          //   handler.resolve(response);
          // } else {
          //   return;
          // }
        } else {
          if (e.response!.statusCode == 444) {
            // final LoginController _controller = Get.put(LoginController());
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            // await prefs.clear();
            // await _controller.googleSignout();
            // navigator!.pushAndRemoveUntil<void>(
            //   MaterialPageRoute<void>(
            //       builder: (BuildContext context) => LoginScreen()),
            //   ModalRoute.withName('/'),
            // );
            // Get.deleteAll();
          }
          if (e.response!.statusCode == 445) {
            final responseData = jsonDecode(e.response.toString());
            final SnackBar snackBar = SnackBar(
                content: Text(
              responseData["response"]["message"],
              style: const TextStyle(color: Colors.white),
            ));
            snackbarKey.currentState?.showSnackBar(snackBar);
            // final LoginController _controller = Get.put(LoginController());
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            // await prefs.clear();
            // await _controller.googleSignout();
            // navigator!.pushAndRemoveUntil<void>(
            //   MaterialPageRoute<void>(
            //       builder: (BuildContext context) => LoginScreen()),
            //   ModalRoute.withName('/'),
            // );
            // Get.deleteAll();
          }
          if (e.response!.statusCode == 446) {
            final responseData = jsonDecode(e.response.toString());
            final SnackBar snackBar =
                SnackBar(content: Text(responseData["response"]["message"]));
            snackbarKey.currentState?.showSnackBar(snackBar);
          }
          if (e.response!.statusCode == 401 || e.response!.statusCode == 500) {
            final responseData = jsonDecode(e.response.toString());
            // print(e.requestOptions.path);
            final SnackBar snackBar =
                SnackBar(content: Text(responseData["response"]["message"]));
            snackbarKey.currentState?.showSnackBar(snackBar);
          }
          handler.next(e);
        }
      }
    }));
    return dio;
  }
}
