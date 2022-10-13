import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_bolierplate_getx/core/reponsive/SizeConfig.dart';
import 'package:mvc_bolierplate_getx/feature/home/controller/home_controller.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyApp"),
        actions: [Icon(Icons.shopping_bag)],
      ),
      body: Wrap(
        // shrinkWrap: true,
        // crossAxisCount: MediaQuery.of(context).size.width ~/ 200,
        children: List.generate(
            _homeController.items.length,
            (index) => CardTileWidget(
                  prod_name: _homeController.items.elementAt(index),
                  prod_rate: 200,
                  prod_subtext: "",
                )),
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
    );
  }
}
