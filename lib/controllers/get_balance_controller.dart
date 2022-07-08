// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../constants.dart';
import '../models/userbalance.dart';

class BalanceController extends GetxController {
  // Obtain shared preferences.
  late SharedPreferences sharedPrefs;
  int balance = 0;

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };

  updateBalance() async {
    sharedPrefs = await SharedPreferences.getInstance();
    // Try reading data from the 'counter' key. If it doesn't exist, returns null.
    final int? userid = sharedPrefs.getInt('userId');
    print(userid);
    final response = await http.get(
      Uri.parse("http://" + apiUrl + "/fetch/userBalance/${userid}"),
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
