import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mvc_bolierplate_getx/feature/home/models/food_item_datamodel.dart';
import 'package:mvc_bolierplate_getx/feature/home/service/service.dart';

class HomeController extends GetxController {
  RxList<FoodItem> items = <FoodItem>[].obs;
  RxList cart = [].obs;
  late Box cartBox;
  @override
  onInit() {
    super.onInit();
  }

  fetchItems() async {
    items.value = await HomeServices().getItems();
  }

  startDb() async {
    // Create a box collection
    cartBox = await Hive.openBox('Cart');
  }

  addProduct(FoodItem item) {
    var response = cartBox.get(item.id);
    print(response);
    if (response != null) {
      response['quantity'] = response['quantity'] + 1;
      cartBox.put(item.id, response);
    } else {
      print('put item');
      cartBox.put(item.id, item.toJson()).then((value) {
        print("object : ${cartBox.get(item.id)}");
      });
    }
  }

  removeProduct(FoodItem item) {
    var response = cartBox.get(item.id);
    response['quantity'] = response['quantity'] - 1;
    if (response['quantity'] > 0) {
      cartBox.put(item.id, response);
    } else {
      cartBox.delete(item.id);
    }
  }
}
