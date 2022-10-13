import 'package:flutter/material.dart';
import 'package:mvc_bolierplate_getx/core/constants/app_text_style.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Order History"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Otp : ', style: AppTextStyle.blackBold20),
                    Container(
                      width: 100,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            hintText: "1234",
                            hintStyle: AppTextStyle.blackBold20,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black12, width: 1),
                            borderRadius: BorderRadius.circular(
                              10,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, top: 10, left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
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
                                          style: AppTextStyle.blackBold14),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          'Creamy Pesto infused with penne\npasta topped with olivers and\ngrated cheese',
                                          style: AppTextStyle.greyMedium10),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "1 x Virgin Mojito",
                                  style: AppTextStyle.blackBold14,
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
