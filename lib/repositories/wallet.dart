import 'dart:convert';

import 'package:fineance/repositories/user.dart';

import 'goal.dart';

class Remittance {
  Remittance({
    required this.description,
    required this.date,
    required this.value,
  });

  String description;
  String date;
  int value;

  factory Remittance.fromRawJson(String str) =>
      Remittance.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Remittance.fromJson(Map<String, dynamic> json) => Remittance(
        description: json["description"].toString(),
        date: json["date"].toString(),
        value: json["value"] as int,
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "date": date,
        "value": value,
      };
}

class Wallet {
  Wallet({
    this.id,
    required this.name,
    required this.description,
    required this.owner,
    required this.currency,
    required this.subowners,
    required this.goal,
    required this.value,
  });

  String? id;
  String name;
  String description;
  User owner;
  String currency;
  List<User> subowners;
  List<Goal> goal;
  List<Remittance> value;

  factory Wallet.fromRawJson(String str) =>
      Wallet.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["_id"].toString(),
        name: json["name"].toString(),
        description: json["description"].toString(),
        owner: User.fromJson(json["owner"] as Map<String, dynamic>),
        currency: json["currency"].toString(),
        subowners: [],
        // subowners: List<User>.from(
        //     (tryCAst(dyn: json["subowners"])).map((x) => User.fromJson(x))),
        goal: [],
        // goal: List<Goal>.from(
        //     (tryCAst(dyn: json["goals"])).map((x) => Goal.fromJson(x))),
        value: [],
        // value: List<Remittance>.from((tryCAst(dyn: json["remittance"]))
        //     .map((x) => Remittance.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "owner": owner.toJson(),
        "currency": currency,
        "subowners": [], //List<dynamic>.from(subowners.map((x) => x.toJson())),
        "goals": [],
        "remittance": [],
        // "goals": List<dynamic>.from(goal.map((x) => x.toJson())),
        // "remittance": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}

List<Map<String, dynamic>> tryCAst({required dynamic dyn}) =>
    dyn as List<Map<String, dynamic>>;
