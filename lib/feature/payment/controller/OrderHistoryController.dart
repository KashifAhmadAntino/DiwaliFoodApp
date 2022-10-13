import 'package:get/get.dart';
import 'package:mvc_bolierplate_getx/feature/payment/model/oderHistoryModel.dart';
import 'package:mvc_bolierplate_getx/feature/payment/service/orderHistoryServices.dart';

class OrderHistoryController extends GetxController {
  final orderHistoryServices = OrderHistorServices();
  Rx<OrderHistory> data = OrderHistory().obs;
  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  fetch() async {
    data.value = (await orderHistoryServices.getData());
    print(data.value.toJson().toString());
  }
}
