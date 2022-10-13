import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvc_bolierplate_getx/core/reponsive/SizeConfig.dart';
import 'package:mvc_bolierplate_getx/feature/home/controller/home_controller.dart';
import 'package:mvc_bolierplate_getx/feature/home/service/service.dart';
import 'package:mvc_bolierplate_getx/feature/home/widget/card_tile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    _homeController.startDb();
    print('fetching items');

    _homeController.fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("MyApp"),
          actions: [
            GestureDetector(
                onTap: () => print("hi"), child: Icon(Icons.shopping_bag))
          ],
        ),
        body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: _homeController.items.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : WatchBoxBuilder(
                    box: Hive.box('Cart'),
                    builder: ((context, box) {
                      return Wrap(
                        // shrinkWrap: true,
                        // crossAxisCount: MediaQuery.of(context).size.width ~/ 200,
                        spacing: 10,
                        runSpacing: 10,
                        //alignment: WrapAlignment.spaceAround,
                        children: List.generate(_homeController.items.length,
                            (index) {
                          print(box.get(_homeController.items[index].id));
                          return CardTileWidget(
                            prod_name: _homeController.items[index].name,
                            prod_rate: _homeController.items[index].price,
                            prod_subtext:
                                _homeController.items[index].discription,
                            prod_url: _homeController.items[index].url,
                            addProduct: () {
                              _homeController
                                  .addProduct(_homeController.items[index]);
                            },
                            counter:
                                box.get(_homeController.items[index].id) ?? 0,
                            removeProduct: () {
                              _homeController
                                  .removeProduct(_homeController.items[index]);
                            },
                          );
                        }),
                      );
                    }))

            // ValueListenableBuilder(
            //   valueListenable: Hive.box<Map<String,dynamic>>('Cart').listenable(),
            //                     builder: (context, cartbox,child)  {
            //     return Wrap(
            //       // shrinkWrap: true,
            //       // crossAxisCount: MediaQuery.of(context).size.width ~/ 200,
            //       spacing: 10,
            //       runSpacing: 10,
            //       //alignment: WrapAlignment.spaceAround,
            //       children: List.generate(
            //           _homeController.items.length,
            //           (index) => CardTileWidget(
            //                 prod_name: _homeController.items[index].name,
            //                 prod_rate: _homeController.items[index].price,
            //                 prod_subtext: _homeController.items[index].discription,
            //                 prod_url: _homeController.items[index].url,
            //                 addProduct: () {
            //                   _homeController
            //                       .addProduct(_homeController.items[index]);
            //                 },
            //                 counter: ,
            //                 removeProduct: () {
            //                   _homeController
            //                       .removeProduct(_homeController.items[index]);
            //                 },
            //               )),
            //     );
            //     }
            //   ),
            ),
        bottomNavigationBar: _homeController.cart.length == 0
            ? Container()
            : Container(
                height: 50 * SizeConfig.heightMultiplier!,
                margin: EdgeInsets.all(10.0 * SizeConfig.heightMultiplier!),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Proceed"),
                ),
              ),
      ),
    );
  }
}
