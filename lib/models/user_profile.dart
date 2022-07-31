// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.balance,
    required this.accountNumber
  });

  int? id;
  String name;
  String email;
  String password;
  int? balance;
  String accountNumber;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        balance: json["balance"], 
        accountNumber: json["accountNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "balance": balance,
        "accountNumber": accountNumber,
      };
}
