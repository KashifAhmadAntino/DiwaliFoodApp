import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_bolierplate_getx/core/constants/app_text_style.dart';
import 'package:mvc_bolierplate_getx/feature/payment/controller/orderHistoryController.dart';

class OrderHistory extends StatelessWidget {
  OrderHistory({Key? key}) : super(key: key);

  final OrderHistoryController orderHistoryController =
      Get.put(OrderHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text("Order History"),
      ),
      body: GetBuilder<OrderHistoryController>(builder: (controller) {
        print("${orderHistoryController.data.value.status}");
        return orderHistoryController.data.value.status == null
            ? const Center(
                child: Text("No items"),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              (orderHistoryController.data.value.data!).length,
                          itemBuilder: (context, index) {
                            final element = orderHistoryController
                                .data.value.data!
                                .elementAt(index);
                            RxBool show = false.obs;
                            return Obx(() => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.grey[100],
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
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
                                              Text(element.otp.toString(),
                                                  style:
                                                      AppTextStyle.blackBold20),
                                            ],
                                          ),
                                          const SizedBox(
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
                                                    element.items!.first.url
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      element.items!.first.name
                                                          .toString(),
                                                      style: AppTextStyle
                                                          .blackBold14),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      element.items!.first
                                                          .discription
                                                          .toString(),
                                                      style: AppTextStyle
                                                          .greyMedium10),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Divider(
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
                                                  child: const Icon(
                                                      Icons.arrow_drop_down))
                                            ],
                                          ),
                                          ...List.generate(
                                            show.value
                                                ? element.items!.length
                                                : 0,
                                            (index1) => Text(
                                              "${element.items!.elementAt(index1).quantity} x ${element.items!.elementAt(index1).name}",
                                              style: AppTextStyle.blackBold14,
                                            )..marginSymmetric(vertical: 5),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "OrderId : ",
                                                style: AppTextStyle.blackBold14,
                                              ),
                                              Text(
                                                element.id.toString(),
                                                style:
                                                    AppTextStyle.greyMedium14,
                                              ),
                                            ],
                                          ),
                                          const Divider(
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
                                                element.finalPrice.toString(),
                                                style:
                                                    AppTextStyle.greyMedium14,
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
              );
      }),
    );
  }
}
