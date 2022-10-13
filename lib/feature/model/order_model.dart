// To parse this JSON data, do
//
//     final orderData = orderDataFromJson(jsonString);

import 'dart:convert';

OrderData orderDataFromJson(String str) => OrderData.fromJson(json.decode(str));

String orderDataToJson(OrderData data) => json.encode(data.toJson());

class OrderData {
  OrderData({
    required this.orderNo,
    required this.otp,
    required this.id,
    required this.finalPrice,
    required this.orderDataId,
  });

  final int orderNo;
  final String otp;
  final String id;
  final int finalPrice;
  final String orderDataId;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        orderNo: json["orderNo"],
        otp: json["otp"],
        id: json["_id"],
        finalPrice: json["finalPrice"],
        orderDataId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "orderNo": orderNo,
        "otp": otp,
        "_id": id,
        "finalPrice": finalPrice,
        "id": orderDataId,
      };
}
