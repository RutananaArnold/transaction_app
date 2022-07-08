// To parse this JSON data, do
//
//     final messageResponse = messageResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MessageResponse messageResponseFromJson(String str) => MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) => json.encode(data.toJson());

class MessageResponse {
    MessageResponse({
        required this.msg,
    });

    final String msg;

    factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
    };
}
