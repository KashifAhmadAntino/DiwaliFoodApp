import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mvc_bolierplate_getx/core/api_service/dio_service.dart';
import 'package:mvc_bolierplate_getx/core/routes/api_routes.dart';
import 'package:mvc_bolierplate_getx/feature/home/models/food_item_datamodel.dart';

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
}
