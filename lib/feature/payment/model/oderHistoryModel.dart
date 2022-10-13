// To parse this JSON data, do
//
//     final orderHistory = orderHistoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderHistory orderHistoryFromJson(String str) =>
    OrderHistory.fromJson(json.decode(str));

String orderHistoryToJson(OrderHistory data) => json.encode(data.toJson());

class OrderHistory {
  OrderHistory({
    this.status,
    this.message,
    this.data,
  });

  final int? status;
  final String? message;
  final List<Datum>? data;

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.finalPrice,
    required this.otp,
    required this.items,
    required this.orderNo,
  });

  final String? id;
  final int? finalPrice;
  final String? otp;
  final List<Item>? items;
  final int? orderNo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        finalPrice: json["finalPrice"],
        otp: json["otp"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        orderNo: json["orderNo"] == null ? null : json["orderNo"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "finalPrice": finalPrice,
        "otp": otp,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "orderNo": orderNo == null ? null : orderNo,
      };
}

class Item {
  Item({
    required this.id,
    required this.quantity,
    required this.name,
    required this.price,
    required this.url,
    required this.discription,
  });

  final String? id;
  final int? quantity;
  final String? name;
  final String? price;
  final String? url;
  final String? discription;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        quantity: json["quantity"],
        name: json["name"],
        price: json["price"],
        url: json["url"],
        discription: json["discription"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "quantity": quantity,
        "name": name,
        "price": price,
        "url": url,
        "discription": discription,
      };
}
