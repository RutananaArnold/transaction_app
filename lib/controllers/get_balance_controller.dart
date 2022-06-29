// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ffi';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class BalanceController extends GetxController {
  int balance = 0;
  int user2balance = 0;

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };

  updateBalance() async {
    var response = await http.get(
      Uri.parse("https://ve8yx5.deta.dev/api/user/fetch/1"),
      headers: _setHeaders(),
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      balance = jsonResponse;
      update();
    }
  }

  updateUser2Balance() async {
    var response = await http.get(
      Uri.parse("https://ve8yx5.deta.dev/api/user/fetch/2"),
      headers: _setHeaders(),
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      user2balance = jsonResponse;
      update();
    }
  }

  int getBalance() {
    return balance;
  }

  int getUser2Balance() {
    return user2balance;
  }
}
