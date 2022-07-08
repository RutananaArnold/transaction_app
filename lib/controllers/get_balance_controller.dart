// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../constants.dart';
import '../models/userbalance.dart';

class BalanceController extends GetxController {
  int balance = 0;

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };

  updateBalance() async {
    final response = await http.get(
      Uri.parse("http://" + apiUrl + "/fetch/userBalance/12"),
      headers: _setHeaders(),
    );
    if (response.statusCode == 200) {
      var jsonResponse = UserBalance.fromJson(jsonDecode(response.body));
      balance = jsonResponse.userBalance!;
      update();
    }
  }

  int getBalance() {
    return balance;
  }
}
