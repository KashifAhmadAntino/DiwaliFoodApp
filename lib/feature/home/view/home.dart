import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvc_bolierplate_getx/core/cookie_service.dart';
import 'package:mvc_bolierplate_getx/core/reponsive/SizeConfig.dart';
import 'package:mvc_bolierplate_getx/feature/home/controller/home_controller.dart';
import 'package:mvc_bolierplate_getx/feature/home/service/service.dart';
import 'package:mvc_bolierplate_getx/feature/home/widget/card_tile_widget.dart';
import 'package:mvc_bolierplate_getx/feature/payment/view/payment.dart';
import 'package:mvc_bolierplate_getx/feature/payment/view/order_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());

  late PageController _pageController;

  List<String> images = [
    "assets/meme1.png",
    "assets/meme2.png",
    "assets/meme3.png"];

  int activePage = 1;

  @override
  void initState() {
    // TODO: implement initState
    _homeController.startDb();
    _homeController.func();
    print('fetching items');

    _homeController.fetchItems();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    super.initState();
  }

  AnimatedContainer slider(images, pagePosition, active) {
    double margin = active ? 10 : 20;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      decoration:  BoxDecoration(
          image: DecorationImage( image: AssetImage(images[pagePosition]))),
    );
  }

  imageAnimation(PageController animation, images, pagePosition) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, widget) {
        print(pagePosition);
        return SizedBox(
          width: 200,
          height: 200,
          child: widget,
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Image.network(images[pagePosition]),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text("Food Wizard"),
            actions: [
              if (_homeController.token.value.isNotEmpty)
                GestureDetector(
                    onTap: () => Get.to(() => OrderHistory()),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Icon(Icons.menu),
                    ))
            ],
          ),
          body: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Expanded(
                      child: _homeController.items.isEmpty
                          ? _homeController.isFetched.value
                              ? _carousalView()
                              : const Center(
                                  child: CircularProgressIndicator(),
                                )
                          : WatchBoxBuilder(
                              box: Hive.box('Cart'),
                              builder: ((context, box) {
                                return SingleChildScrollView(
                                  child: Wrap(
                                    // shrinkWrap: true,
                                    // crossAxisCount: MediaQuery.of(context).size.width ~/ 200,
                                    spacing: 10,
                                    runSpacing: 10,
                                    //alignment: WrapAlignment.spaceAround,
                                    children: List.generate(
                                        _homeController.items.length, (index) {
                                      final item = box
                                          .get(_homeController.items[index].id);
                                      // try {
                                      //   if (item != null) {
                                      //     final cartitem = Map<String, dynamic>.from(box
                                      //         .get(_homeController.items[index].id) as Map);
                                      //     print(cartitem['quantity']);
                                      //   }
                                      //   print('json');
                                      // } on Exception {
                                      //   print(item);
                                      // }
                                      //print(item['quantity']);

                                      return CardTileWidget(
                                        prod_name:
                                            _homeController.items[index].name,
                                        prod_rate:
                                            _homeController.items[index].price,
                                        prod_subtext: _homeController
                                            .items[index].discription,
                                        prod_url:
                                            _homeController.items[index].url,
                                        addProduct: () {
                                          _homeController.addProduct(
                                              _homeController.items[index]);
                                        },
                                        counter: item != null
                                            ? Map<String, dynamic>.from(box.get(
                                                _homeController.items[index]
                                                    .id) as Map)['quantity']
                                            : 0,
                                        //  box.get(_homeController.items[index].id) ?? 0,
                                        removeProduct: () {
                                          _homeController.removeProduct(
                                              _homeController.items[index]);
                                        },
                                      );
                                    }),
                                  ),
                                );
                              }))),
                  _homeController.items.isEmpty
                      ? SizedBox.shrink()
                      : WatchBoxBuilder(
                          box: Hive.box('Cart'),
                          builder: ((context, box) {
                            return box.isEmpty
                                ? Container(
                                    height: 0,
                                  )
                                : SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => const PaymentScreen());
                                      },
                                      child: const Text("Proceed"),
                                    ),
                                  );
                          }))
                ],
              )
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
        ));
  }


  Widget _carousalView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("We are serving soon !!",style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,

        ),),
        SizedBox(
          height: 40,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: PageView.builder(
              itemCount: images.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                bool active = pagePosition == activePage;
                return slider(images, pagePosition, active);
              }),
        ),

        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(images.length,activePage))
      ],
    );

  }
}


