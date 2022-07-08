// To parse this JSON data, do
//
//     final userBalance = userBalanceFromJson(jsonString);

import 'dart:convert';

UserBalance userBalanceFromJson(String str) => UserBalance.fromJson(json.decode(str));

String userBalanceToJson(UserBalance data) => json.encode(data.toJson());

class UserBalance {
    int? userId;

    UserBalance({
        this.userId,
    });


    factory UserBalance.fromJson(Map<String, dynamic> json) => UserBalance(
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
    };
}
