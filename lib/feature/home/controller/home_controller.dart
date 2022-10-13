import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList items = ["Item1", "Item2", "Item3", "Item1", "Item2", "Item3"].obs;
  RxList cart = [].obs;
}
