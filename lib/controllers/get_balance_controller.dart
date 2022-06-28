// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:transaction_app/constants.dart';

class BalanceController extends GetxController {
  late String balance = "0";

  updateBalance() async {
    var jsonResponse;

    var response = await http.get(
      Uri.parse("http://" + apiUrl + "/api/user/fetch/1"),
      // headers: _setHeaders(),
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        
      }
    }
  }

 String getBalance() {
    return balance;
  }
}
