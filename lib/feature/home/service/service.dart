import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mvc_bolierplate_getx/core/api_service/dio_service.dart';
import 'package:mvc_bolierplate_getx/core/cookie_service.dart';
import 'package:mvc_bolierplate_getx/core/routes/api_routes.dart';
import 'package:mvc_bolierplate_getx/feature/home/models/food_item_datamodel.dart';
import 'package:mvc_bolierplate_getx/feature/model/order_model.dart';

class HomeServices {
  static var dio = DioUtil().getInstance();
  getItems() async {
    final response = await dio!.get(ApiUrl.getItems);
    print(response.data);
    if (response.data != null) {
      print('object');
      final responseDecode = json.decode(response.toString());
      print(responseDecode);
      final items = List<FoodItem>.from(
          responseDecode['data'].map((item) => FoodItem.fromJson(item)));
      print(items.length);
      return items;
    }
    log('not working');
    return List<FoodItem>.empty();
  }

  login(String name, String phoneNo) async {
    final response = await dio!
        .post(ApiUrl.getToken, data: {"firstName": name, "phone": phoneNo});
    print(response.data);
    if (response.data != null) {
      print('object');
      final responseDecode = json.decode(response.toString());
      print(responseDecode['data']['token']);
      CookieManager().addToCookie("id", responseDecode['data']['token']);
      return responseDecode['data']['token'];
    }
    log('not working');
    return '';
  }

  placeOrder(List<Map<String, dynamic>> items) async {
    final response = await dio!.post(ApiUrl.placeOrder, data: {"items": items});
    print(response.data);
    if (response.data != null) {
      print('object');
      final responseDecode = json.decode(response.toString());
      print(responseDecode['data']);

      return OrderData.fromJson(responseDecode['data']);
    }
    log('not working');
    return;
  }
}
