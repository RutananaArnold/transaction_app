// To parse this JSON data, do
//
//     final userBalance = userBalanceFromJson(jsonString);

import 'dart:convert';

UserBalance userBalanceFromJson(String str) =>
    UserBalance.fromJson(json.decode(str));

String userBalanceToJson(UserBalance data) => json.encode(data.toJson());

class UserBalance {
  UserBalance({
    this.userBalance,
  });

  int? userBalance;

  factory UserBalance.fromJson(Map<String, dynamic> json) => UserBalance(
        userBalance: json["userBalance"],
      );

  Map<String, dynamic> toJson() => {
        "userBalance": userBalance,
      };
}
