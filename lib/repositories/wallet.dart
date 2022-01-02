import 'dart:convert';

import 'package:fineance/repositories/user.dart';
import 'package:fl_chart/fl_chart.dart';

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

  int get wholeValue {
    int val = 0;
    value.forEach((element) {
      val += element.value;
    });
    return val;
  }

  Goal nextGoal() {
    int val = 0;
    value.forEach((element) {
      val += element.value;
    });

    List<Goal> goals = List<Goal>.empty(growable: true);
    goal.forEach((element) {
      if (element.value > val) {
        goals.add(element);
      }
    });
    goals.sort();
    if (goals.length>0) {
      return goals[0];
    }
    return Goal(date: "null",name:"null",value: 0);
  }

  List<FlSpot> calculatePointToDisplayWholeValue(){
    List<FlSpot> spots = List<FlSpot>.empty(growable: true);
    int val = 0;
    int x=0;
    spots.add(new FlSpot(x.toDouble(), 0));
    value.forEach((element) {
      x++;
      val += element.value;
      spots.add(new FlSpot(x.toDouble(), val.toDouble()));
    });
    return spots;
  }

  List<FlSpot> calculatePointToDisplay(){
    List<FlSpot> spots = List<FlSpot>.empty(growable: true);
    int x=0;
    spots.add(new FlSpot(x.toDouble(), 0));
    value.forEach((element) {
      x++;
      spots.add(new FlSpot(x.toDouble(), element.value.toDouble()));
    });
    return spots;
  }



  factory Wallet.fromRawJson(String str) =>
      Wallet.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["_id"].toString(),
        name: json["name"].toString(),
        description: json["description"].toString(),
        owner: User.fromJson(json["owner"] as Map<String, dynamic>),
        currency: json["currency"].toString(),
        subowners: List<User>.from(tryCAstList(json["subowners"])
                .map((x) => User.fromJson(x as Map<String, dynamic>)))
            as List<User>,
        goal: List<Goal>.from(tryCAstList(json["goals"])
                .map((x) => Goal.fromJson(x as Map<String, dynamic>)))
            as List<Goal>,
        value: List<Remittance>.from(tryCAstList(json["remittance"])
                .map((x) => Remittance.fromJson(x as Map<String, dynamic>)))
            as List<Remittance>,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "owner": owner.toJson(),
        "currency": currency,
        "subowners": List<dynamic>.from(subowners.map((x) => x.toJson())),
        "goals": List<dynamic>.from(goal.map((x) => x.toJson())),
        "remittance": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}

List<dynamic> tryCAstList(dynamic dyn) {
  if (dyn != null) {
    return dyn as List<dynamic>;
  } else {
    return List.empty();
  }
}

List<Map<String, dynamic>> tryCAst(dynamic dyn) {
  if (dyn != null) {
    return dyn as List<Map<String, dynamic>>;
  } else {
    return List.empty();
  }
}
