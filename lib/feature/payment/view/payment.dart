import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mvc_bolierplate_getx/core/cookie_service.dart';
import 'package:mvc_bolierplate_getx/feature/home/service/service.dart';
import 'package:mvc_bolierplate_getx/feature/payment/controller/payment_controller.dart';
import 'package:mvc_bolierplate_getx/feature/payment/view/order_success.dart';

import '../../model/payment_model.dart';
import 'order_history.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentController paymentController = PaymentController();
  @override
  void initState() {
    super.initState();

    callJson();
  }

  PaymentModel result = PaymentModel();

  String? name;
  String? phoneNo;
  final formKey = GlobalKey<FormState>();

  Future<void> callJson() async {
    // String data =
    //     await DefaultAssetBundle.of(context).loadString("assets/sample.json");
    // final jsonResult = jsonDecode(data);
    List cartitems = [];
    final data = Hive.box('Cart');
    print("gerer");
    try {
      for (var element in data.keys) {
        final item = Map<String, dynamic>.from(data.get(element) as Map);
        cartitems.add(item);
        print(item);
      }
      final jsonResult = {'items': cartitems.toList()};
      PaymentModel paymentModel = PaymentModel.fromJson(jsonResult);
      setState(() {
        result = paymentModel;
      });

      getTotal();
    } catch (e) {
      print(e);
    }
  }

  getTotal() {
    for (var i = 0; i < result.items!.length; i++) {
      setState(() {
        paymentController.grand_total.value +=
            int.parse(result.items![i].amount!) * result.items![i].quantity!;
      });
      print(paymentController.grand_total.value.toString() + "hema");
    }
  }

  loginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: 300,
              child: Stack(
                  //overflow: Overflow.visible,
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                        top: -100,
                        child: Image.asset("assets/image-1.png",
                            width: 175, height: 175)),
                    Form(
                      key: formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Enter Your Details!",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                onSaved: (value) {
                                  name = value!.trim();
                                },
                                validator: (value) {
                                  return value == null || value.isEmpty
                                      ? "Name is empty"
                                      : null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Enter your name"),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                onSaved: (value) {
                                  phoneNo = value!.trim();
                                },
                                validator: (value) {
                                  return value == null ||
                                          value.trim().length != 10
                                      ? "Mobile number is empty/invalid"
                                      : null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Enter your phone number"),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 0),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            final token = await HomeServices()
                                                .login(name.toString(),
                                                    phoneNo.toString());
                                            print("token : $token");
                                            if (token.isNotEmpty()) {
                                              final order = await HomeServices()
                                                  .placeOrder(result.items!
                                                      .map((item) => {
                                                            "itemId": item.id,
                                                            "quantity":
                                                                item.quantity
                                                          })
                                                      .toList());
                                              if (order != null) {
                                                Navigator.pop(context);
                                                Get.off(() =>
                                                    OrderSuccess(order: order));
                                                // Get.to(()=>)
                                              } else {
                                                Navigator.pop(context);
                                              }
                                            }
                                          }
                                        },
                                        child: const Text(
                                          'Place Order!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontStyle: FontStyle.italic),
                                        )),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ]),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Order Screen"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, top: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Order",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: result.items?.length ?? 0,
                  itemBuilder: (context, index) {
                    paymentController.food_amount.value =
                        int.parse(result.items![index].amount!) *
                            result.items![index].quantity!;
                    // grand_total += food_amount!;
                    // print(grand_total);
                    // food_quantity = int.parse(result.items![index].quantity!);

                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 120,
                        width: 360,
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result.items![index].title!,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Quantity : ${result.items![index].quantity!}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Text(
                                  '₹ ${paymentController.food_amount.value.toString()}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Container(
                                //   height: 30,
                                //   decoration: BoxDecoration(
                                //       color: Colors.red[50],
                                //       border: Border.all(color: Colors.red),
                                //       borderRadius: BorderRadius.circular(10)),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       IconButton(
                                //           onPressed: () {
                                //             decrement();
                                //           },
                                //           icon: Icon(
                                //             Icons.remove,
                                //             size: 15,
                                //           )),
                                //       Text('$up'),
                                //       IconButton(
                                //           onPressed: () {
                                //             increment();
                                //           },
                                //           icon: Icon(
                                //             Icons.add,
                                //             size: 14,
                                //           )),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  result.items![index].imageUrl!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              Column(
                children: [
                  Container(
                    // height: 250,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Bill Summary",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Developer Tax",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "₹ 20",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Antino Discount",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "₹ -20",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Item total",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              result.items == null
                                  ? "0"
                                  : ('₹ ${paymentController.grand_total.value.toString()}'),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          thickness: 0.6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Grand Total",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '₹ ${paymentController.grand_total.value.toString()}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final token = CookieManager().getCookie("id");
                      if (token.isNotEmpty) {
                        final order = await HomeServices().placeOrder(result
                            .items!
                            .map((item) =>
                                {"itemId": item.id, "quantity": item.quantity})
                            .toList());
                        if (order != null) {
                          Hive.box('Cart').clear();
                          Get.off(() => OrderSuccess(order: order));
                          // Get.to(()=>)
                        } else {}
                      }
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Proceed",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
