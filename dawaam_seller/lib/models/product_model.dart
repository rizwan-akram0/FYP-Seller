// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
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

  Product({
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

  Product copyWith({
    String? id,
    String? name,
    int? price,
    int? oldPrice,
    String? description,
    List<String>? images,
    String? category,
    List<String>? tag,
    String? subCategory,
    int? stock,
    String? sellerId,
    int? sales,
    List<dynamic>? ratings,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        oldPrice: oldPrice ?? this.oldPrice,
        description: description ?? this.description,
        images: images ?? this.images,
        category: category ?? this.category,
        tag: tag ?? this.tag,
        subCategory: subCategory ?? this.subCategory,
        stock: stock ?? this.stock,
        sellerId: sellerId ?? this.sellerId,
        sales: sales ?? this.sales,
        ratings: ratings ?? this.ratings,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json["_id"],
        name: json["name"],
        price: json["price"] is int
            ? json["price"]
            : int.tryParse(json["price"].toString()) ?? 0,
        oldPrice: json["oldPrice"] is int
            ? json["oldPrice"]
            : int.tryParse(json["oldPrice"].toString()) ?? 0,
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        category: json["category"],
        tag: List<String>.from(json["tag"].map((x) => x)),
        subCategory: json["subCategory"],
        stock: json["stock"] is int
            ? json["stock"]
            : int.tryParse(json["stock"].toString()) ?? 0,
        sellerId: json["sellerId"],
        sales: json["sales"],
        ratings: json["ratings"] is List
            ? List<dynamic>.from(json["ratings"].map((x) => x))
            : [],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
    } catch (e) {
      log("Error parsing JSON: $e");
      rethrow;
    }
  }

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
