// To parse this JSON data, do
//
//     final foodItem = foodItemFromJson(jsonString);

import 'dart:convert';

FoodItem foodItemFromJson(String str) => FoodItem.fromJson(json.decode(str));

String foodItemToJson(FoodItem data) => json.encode(data.toJson());

class FoodItem {
  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.discription,
    required this.url,
  });

  final String id;
  final String name;
  final String price;
  final String discription;
  final String url;

  factory FoodItem.fromJson(Map<String, dynamic> json) => FoodItem(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        discription: json["discription"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "discription": discription,
        "url": url,
        "quantity": 1
      };
}
