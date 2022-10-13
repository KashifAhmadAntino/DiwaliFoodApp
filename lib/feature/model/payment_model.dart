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
  String? title;
  String? imageUrl;
  String? quantity;
  String? amount;

  Items({this.title, this.imageUrl, this.quantity, this.amount});

  Items.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageUrl = json['imageUrl'];
    quantity = json['quantity'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['imageUrl'] = this.imageUrl;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    return data;
  }
}
