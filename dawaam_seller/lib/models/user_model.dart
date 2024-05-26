// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  String status;
  Data data;

  Users({
    required this.status,
    required this.data,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  String message;
  List<User> user;

  Data({
    required this.message,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
      };
}

class User {
  String name;
  String email;
  String id;

  User({
    required this.name,
    required this.email,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "id": id,
      };
}
