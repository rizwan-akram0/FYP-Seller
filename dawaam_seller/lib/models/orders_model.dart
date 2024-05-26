// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  String message;
  List<OrderElement> orders;

  Order({
    required this.message,
    required this.orders,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        message: json["message"],
        orders: List<OrderElement>.from(
            json["orders"].map((x) => OrderElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class OrderElement {
  String id;
  String orderId;
  String userId;
  String sellerId;
  List<Item> items;
  int totalAmount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  OrderElement({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.sellerId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory OrderElement.fromJson(Map<String, dynamic> json) => OrderElement(
        id: json["_id"],
        orderId: json["orderId"],
        userId: json["userId"],
        sellerId: json["sellerId"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        totalAmount: json["totalAmount"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "orderId": orderId,
        "userId": userId,
        "sellerId": sellerId,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "totalAmount": totalAmount,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Item {
  ProductId productId;
  int quantity;
  int price;
  String id;

  Item({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: ProductId.fromJson(json["productId"]),
        quantity: json["quantity"],
        price: json["price"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId.toJson(),
        "quantity": quantity,
        "price": price,
        "_id": id,
      };
}

class ProductId {
  String id;
  String name;
  int price;
  int oldPrice;
  String description;
  List<String> images;
  String category;
  List<String> tag;
  String subCategory;
  int stock;
  String sellerId;
  int sales;
  List<dynamic> ratings;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ProductId({
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.description,
    required this.images,
    required this.category,
    required this.tag,
    required this.subCategory,
    required this.stock,
    required this.sellerId,
    required this.sales,
    required this.ratings,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        oldPrice: json["oldPrice"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        category: json["category"],
        tag: List<String>.from(json["tag"].map((x) => x)),
        subCategory: json["subCategory"],
        stock: json["stock"],
        sellerId: json["sellerId"],
        sales: json["sales"],
        ratings: List<dynamic>.from(json["ratings"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "oldPrice": oldPrice,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "category": category,
        "tag": List<dynamic>.from(tag.map((x) => x)),
        "subCategory": subCategory,
        "stock": stock,
        "sellerId": sellerId,
        "sales": sales,
        "ratings": List<dynamic>.from(ratings.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
