import 'package:mvc_bolierplate_getx/core/api_service/dio_service.dart';
import 'package:mvc_bolierplate_getx/core/routes/api_routes.dart';
import 'package:mvc_bolierplate_getx/feature/payment/model/oderHistoryModel.dart';

class OrderHistorServices {
  static var dio = DioUtil().getInstance();
  Future<OrderHistory> getData() async {
    try {
      print("Here");
      final response = await dio!.get(ApiUrl.getOrdersHistory);
      print("Here");
      print(response.data);
      if (response.data != null) {
        print("returning");
        return orderHistoryFromJson(response.toString());
      } else {
        return OrderHistory();
      }
    } catch (e) {
      print(e);
      return OrderHistory();
    }
  }
}
