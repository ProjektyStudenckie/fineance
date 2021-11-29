import 'dart:convert';

import 'package:meta/meta.dart';

class User {
  User({
    required this.username,
    required this.password,
    required this.email,
  });

  final String username;
  final String password;
  final String email;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str) as Map<String,dynamic>);

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"].toString(),
    password: json["password"].toString(),
    email: json["email"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "email": email,
  };
}
