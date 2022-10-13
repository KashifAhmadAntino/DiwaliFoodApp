class PaymentModel {
  List<Items>? items;

  PaymentModel({this.items});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? title;
  String? imageUrl;
  int? quantity;
  String? amount;

  Items({this.id, this.title, this.imageUrl, this.quantity, this.amount});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['name'];
    imageUrl = json['url'];
    quantity = json['quantity'];
    amount = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.title;
    data['url'] = this.imageUrl;
    data['quantity'] = this.quantity;
    data['price'] = this.amount;
    return data;
  }
}
