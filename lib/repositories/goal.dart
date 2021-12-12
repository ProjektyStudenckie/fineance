import 'dart:convert';

import 'package:meta/meta.dart';

class Goal {
  Goal({
    required this.name,
    required this.date,
    required this.value,
  });

  final String name;
  final String date;
  final int value;

  factory Goal.fromRawJson(String str) => Goal.fromJson(json.decode(str) as Map<String,dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
    name: json["name"].toString(),
    date: json["date"].toString(),
    value: json["value"] as int,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "date": date,
    "value": value,
  };
}
