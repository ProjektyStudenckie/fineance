import 'dart:convert';

import 'package:fineance/repositories/user.dart';
import 'package:fineance/repositories/wallet.dart';
import 'package:meta/meta.dart';

class UserWallet {
  UserWallet({
    required this.wallet,
    required this.user,
  });

  final Wallet wallet;
  final User user;

  factory UserWallet.fromRawJson(String str) => UserWallet.fromJson(json.decode(str) as Map<String,dynamic>);

  String toRawJson() => json.encode(toJson());

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
    wallet: json["wallet"] as Wallet,
    user: json["user"] as User,
  );

  Map<String, dynamic> toJson() => {
    "wallet": wallet,
    "user": user
  };
}
