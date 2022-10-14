import 'package:get/get.dart';
import 'package:mvc_bolierplate_getx/feature/payment/model/oderHistoryModel.dart';
import 'package:mvc_bolierplate_getx/feature/payment/service/orderHistoryServices.dart';

class OrderHistoryController extends GetxController {
  final orderHistoryServices = OrderHistorServices();
  RxBool loader = false.obs;
  Rx<OrderHistory> data = OrderHistory().obs;
  @override
  void onInit() {
    fetch();
    print("done here");
    super.onInit();
  }

  fetch() async {
    loader.value = true;
    final response = await orderHistoryServices.getData();
    print("there" + response.toString());
    data.value = response;
    print("HI ther " + data.value.toJson().toString());
    loader.value = false;
    update();
  }
}
