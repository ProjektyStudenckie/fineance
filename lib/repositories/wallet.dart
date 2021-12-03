import 'dart:convert';

import 'package:fineance/repositories/user.dart';

class Wallet {
  Wallet({
    required this.id,
    required this.name,
    required this.owner,
    required this.currency,
    required this.subowners,
    required this.value,
  });

  String id;
  String name;
  User owner;
  String currency;
  List<User> subowners;
  int value;

  factory Wallet.fromRawJson(String str) => Wallet.fromJson(json.decode(str) as Map<String,dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json["_id"].toString(),
    name: json["name"].toString(),
    owner: User.fromJson(json["owner"] as Map<String,dynamic>),
    currency: json["currency"].toString(),
    subowners: List<User>.from((json["subowners"] as List<Map<String,dynamic>>).map((x) => User.fromJson(x)))as List<User>,
    value: json["value"] as int,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "owner": owner.toJson(),
    "currency": currency,
    "subowners": List<dynamic>.from(subowners.map((x) => x.toJson())),
    "value": value,
  };
}
