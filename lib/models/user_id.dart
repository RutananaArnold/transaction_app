// To parse this JSON data, do
//
//     final idUser = idUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

IdUser idUserFromJson(String str) => IdUser.fromJson(json.decode(str));

String idUserToJson(IdUser data) => json.encode(data.toJson());

class IdUser {
    IdUser({
        required this.userId,
    });

    final int userId;

    factory IdUser.fromJson(Map<String, dynamic> json) => IdUser(
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
    };
}
