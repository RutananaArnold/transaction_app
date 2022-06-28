// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/constants.dart';
import 'package:transaction_app/widgets/wallet_element.dart';
import 'package:http/http.dart' as http;

class User1 extends StatefulWidget {
  User1({Key? key}) : super(key: key);

  @override
  State<User1> createState() => _User1State();
}

class _User1State extends State<User1> {
  final topupController = TextEditingController();
  final withdrawController = TextEditingController();
  final sendController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.3,
          ),
          // wallet UI starts here
          Container(
              margin: const EdgeInsets.all(10),
              height: size.height / 6,
              width: size.width,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      0.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Text("data"),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WalletElement(
                            icon: Icons.add_box_rounded,
                            label: "Topup",
                            tap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    final size = MediaQuery.of(context).size;
                                    return CupertinoAlertDialog(
                                      content: StatefulBuilder(
                                        builder: (context, setState) {
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                const Text(
                                                    "Enter amount to top up"),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Material(
                                                  child: TextFormField(
                                                    controller: topupController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      topup_request(int.parse(
                                                          topupController
                                                              .text));
                                                    },
                                                    child: const Text("TOPUP"))
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  });
                            }),
                        WalletElement(
                            icon: Icons.file_download_outlined,
                            label: "Withdraw",
                            tap: () {}),
                        WalletElement(
                            icon: Icons.send_rounded, label: "Send", tap: () {})
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  // transaction logic

  _setHeaders() => {
        // 'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };

  topup_request(int amount) async {
    Map data = {
      "balance": amount,
    };
    print(data);

    var jsonResponse;

    var response = await http.put(
      Uri.parse("http://"+ apiUrl+"/api/user/topup/1"),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        Navigator.pop(context);
      }
    } else {
      jsonResponse = json.decode(response.body);
    }
  }
}
