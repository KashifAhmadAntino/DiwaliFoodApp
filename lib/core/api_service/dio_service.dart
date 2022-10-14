// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:mvc_bolierplate_getx/core/alert_dialog.dart';
// import 'package:mvc_bolierplate_getx/core/cookie_service.dart';
// import '../constants/image_path.dart';

// class DioUtil {
//   Dio? _instance;
// //method for getting dio instance
//   Dio? getInstance() {
//     _instance ??= createDioInstance();
//     return _instance;
//   }

//   Dio createDioInstance() {
//     var dio = Dio();

//     // adding interceptor
//     dio.interceptors.clear();
//     dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
// final accessToken = CookieManager().getCookie("id");
// options.headers["Authorization"] = "Bearer $accessToken";
//       return handler.next(options); //modify your request
//     }, onResponse: (response, handler) {
//       // ignore: unnecessary_null_comparison
//       if (response != null) {
//         return handler.next(response);
//       } else {
//         return;
//       }
//     }, onError: (DioError e, handler) async {
//       if (e.response != null) {
//         if (e.response!.statusCode == 401) {
//           ProgressDialog().closeProgressDialog();
//           print(e.response);
//           handler.resolve(e.response!);
//         } else {
//           print(e.response);
//           handler.resolve(e.response!);
//         }
//       }
//     }));
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvc_bolierplate_getx/core/alert_dialog.dart';
import 'package:mvc_bolierplate_getx/core/cookie_service.dart';
import 'package:mvc_bolierplate_getx/feature/payment/model/oderHistoryModel.dart';

class DioUtil {
  Dio? _instance;
//method for getting dio instance
  Dio? getInstance() {
    if (_instance == null) {
      _instance = createDioInstance();
    }
    return _instance;
  }

  Dio createDioInstance() {
    var dio = Dio();
    dio.interceptors.clear();
    return dio
      ..interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        final accessToken = CookieManager().getCookie("id");
        options.headers["Authorization"] = "Bearer " + accessToken;
        options.headers["Accept"] = "*/*";
        options.headers["X-APP-CODE"] = "COOK";
        return handler.next(options); //modify your request
      }, onResponse: (response, handler) {
        // ignore: unnecessary_null_comparison
        if (response != null) {
          //on success it is getting called here
          print(response);
          return handler.next(response);
        } else {
          return handler.next(response);
        }
      }, onError: (DioError e, handler) async {
        log(e.error.toString());
        if (e.response != null) {
          ProgressDialog().closeProgressDialog();
          if (e.response!.statusCode == 401) {
            handler.resolve(e.response!);
          } else {
            handler.resolve(e.response!);
          }
        } else {
          Response<dynamic> res = OrderHistory().toJson() as Response;
          handler.resolve(res);
          print(e.response.toString());
        }
      }));
  }
}
// class AuthInterceptor extends Interceptor {
//   static bool isRetryCall = false;
//
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     bool _token = isTokenExpired(token);
//     bool _refresh = isTokenExpired(refresh);
//     bool _refreshed = true;
//
//     if (_refresh) {
//       appAuth.logout();
//       EasyLoading.showInfo('Expired session');
//       DioError _err;
//       handler.reject(_err);
//     } else if (_token) {
//       _refreshed = await appAuth.refreshToken();
//     }
//     if (_refreshed) {
//       options.headers["Authorization"] = "Bearer " + token;
//       options.headers["Accept"] = "application/json";
//
//       handler.next(options);
//     }
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) async {
//     handler.next(response);
//   }
//
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     handler.next(err);
//   }
// }