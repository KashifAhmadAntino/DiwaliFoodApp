import 'package:get/get.dart';
import 'package:mvc_bolierplate_getx/feature/payment/model/oderHistoryModel.dart';
import 'package:mvc_bolierplate_getx/feature/payment/service/orderHistoryServices.dart';

class OrderHistoryController extends GetxController {
  final orderHistoryServices = OrderHistorServices();
  Rx<OrderHistory> data = OrderHistory().obs;
  @override
  void onInit() {
    fetch();
    print("done here");
    super.onInit();
  }

  fetch() async {
    final response = await orderHistoryServices.getData();
    print(response);
    data.value = response;
    print("HI ther " + data.value.toJson().toString());
    update();
  }
}
