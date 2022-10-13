import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_bolierplate_getx/feature/payment/controller/payment_controller.dart';

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

  Future<void> callJson() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/sample.json");
    final jsonResult = jsonDecode(data);

    PaymentModel paymentModel = PaymentModel.fromJson(jsonResult);
    setState(() {
      result = paymentModel;
    });

    getTotal();
  }

  getTotal() {
    for (var i = 0; i < result.items!.length; i++) {
      setState(() {
        paymentController.grand_total.value +=
            int.parse(result.items![i].amount!) *
                int.parse(result.items![i].quantity!);
      });
      print(paymentController.grand_total.value.toString() + "hema");
    }
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
                            int.parse(result.items![index].quantity!);
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
                                  'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
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
                    onTap: () {
                      Get.to(OrderHistory());
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
