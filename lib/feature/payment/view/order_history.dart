import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_bolierplate_getx/core/constants/app_text_style.dart';
import 'package:mvc_bolierplate_getx/feature/payment/controller/orderHistoryController.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final OrderHistoryController orderHistoryController =
      Get.put(OrderHistoryController());

  @override
  Widget build(BuildContext context) {
    orderHistoryController.fetch;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Order History"),
      ),
      body: Obx(() => (orderHistoryController.data.value.data ?? []).isEmpty
          ? const Center(
              child: Text("No items"),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            (orderHistoryController.data.value.data!).length,
                        itemBuilder: (context, index) {
                          RxBool show = false.obs;
                          return Obx(() => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Colors.grey[100],
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black12, width: 1),
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0,
                                        top: 10,
                                        left: 10,
                                        right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Otp : ',
                                                style:
                                                    AppTextStyle.blackBold20),
                                            Text('1234',
                                                style:
                                                    AppTextStyle.blackBold20),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Grill Masters',
                                                    style: AppTextStyle
                                                        .blackBold14),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    'Creamy Pesto infused with penne\npasta topped with olivers and\ngrated cheese',
                                                    style: AppTextStyle
                                                        .greyMedium10),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Show Items: ',
                                              style: AppTextStyle.blackBold14,
                                            ),
                                            GestureDetector(
                                                onTap: () =>
                                                    show.value = !show.value,
                                                child:
                                                    Icon(Icons.arrow_drop_down))
                                          ],
                                        ),
                                        ...List.generate(
                                          show.value ? 4 : 0,
                                          (index) => Text(
                                            "1 x Virgin Mojito",
                                            style: AppTextStyle.blackBold14,
                                          )..marginSymmetric(vertical: 5),
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "OrderId : ",
                                              style: AppTextStyle.blackBold14,
                                            ),
                                            Text(
                                              "asehBYUhgh",
                                              style: AppTextStyle.greyMedium14,
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total : ",
                                              style: AppTextStyle.blackBold14,
                                            ),
                                            Text(
                                              "920",
                                              style: AppTextStyle.greyMedium14,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        }),
                  ],
                ),
              ),
            )),
    );
  }
}
