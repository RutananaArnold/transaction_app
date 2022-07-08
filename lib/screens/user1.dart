// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/controllers/get_balance_controller.dart';
import 'package:transaction_app/widgets/wallet_element.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/response_message.dart';

class User1 extends StatefulWidget {
  User1({Key? key}) : super(key: key);

  @override
  State<User1> createState() => _User1State();
}

class _User1State extends State<User1> {
  final topupController = TextEditingController();
  final withdrawController = TextEditingController();
  final sendController = TextEditingController();
  final receiverController = TextEditingController();
  final BalanceController balanceController = Get.put(BalanceController());
  // Obtain shared preferences.
  late SharedPreferences sharedPrefs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    balanceController.updateBalance();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.3,
            ),
            const Text(
              "BALANCE:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            GetBuilder<BalanceController>(
              builder: (_) => Text(
                balanceController.getBalance().toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // topup option
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
                                                      controller:
                                                          topupController,
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
                                                        //update my balance
                                                        balanceController
                                                            .updateBalance();
                                                      },
                                                      child:
                                                          const Text("TOPUP"))
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    });
                              }),

                          // withdraw option
                          WalletElement(
                              icon: Icons.file_download_outlined,
                              label: "Withdraw",
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
                                                      "Enter amount to withdraw"),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Material(
                                                    child: TextFormField(
                                                      controller:
                                                          withdrawController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        withdraw_request(
                                                            int.parse(
                                                                withdrawController
                                                                    .text));
                                                        //update my balance
                                                        balanceController
                                                            .updateBalance();
                                                      },
                                                      child: const Text(
                                                          "WITHDRAW"))
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    });
                              }),

                          //send option
                          WalletElement(
                              icon: Icons.send_rounded,
                              label: "Send",
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
                                                    "Enter amount to send",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text("Amount"),
                                                  Material(
                                                    child: TextFormField(
                                                      controller:
                                                          sendController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                  ),
                                                  const Text("Receiver Name"),
                                                  Material(
                                                    child: TextFormField(
                                                      controller:
                                                          receiverController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        send_request(
                                                            int.parse(
                                                                sendController
                                                                    .text),
                                                            receiverController
                                                                .text);
                                                        //update my balance
                                                        balanceController
                                                            .updateBalance();
                                                      },
                                                      child: const Text("SEND"))
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    });
                              })
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  // transaction logic

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };

  topup_request(int amount) async {
    Map data = {
      "balance": amount,
    };
    print(data);

    sharedPrefs = await SharedPreferences.getInstance();
    final int? userid = sharedPrefs.getInt('userId');
    var jsonResponse;

    var response = await http.put(
      Uri.parse("http://" + apiUrl + "/topup/${userid}"),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        final snackBar = SnackBar(
          content: Text('You have topped up ${topupController.text}'),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
    } else {
      jsonResponse = json.decode(response.body);
    }
  }

//withdraw logic
  withdraw_request(int amount) async {
    Map data = {
      "balance": amount,
    };
    print(data);

    sharedPrefs = await SharedPreferences.getInstance();
    final int? userid = sharedPrefs.getInt('userId');
    var jsonResponse;

    var response = await http.put(
      Uri.parse("http://" + apiUrl + "/withdraw/${userid}"),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        final snackBar = SnackBar(
          content: Text('You have withdrawn ${withdrawController.text}'),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
    } else {
      jsonResponse = json.decode(response.body);
      final snackBar = SnackBar(
        content: Text(jsonResponse),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }

//sending logic
  send_request(int amount, String name) async {
    Map data = {
      "balance": amount,
      "name": name,
    };
    print(data);
    sharedPrefs = await SharedPreferences.getInstance();
    final int? userid = sharedPrefs.getInt('userId');

    var jsonResponse;

    var response = await http.put(
      Uri.parse(
          "http://" + apiUrl + "/send/${userid}/${receiverController.text}"),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    if (response.statusCode == 200) {
      jsonResponse = MessageResponse.fromJson(jsonDecode(response.body));
      print(jsonResponse.msg);
      if (jsonResponse != null) {
        final snackBar = SnackBar(
          content: Text(jsonResponse.msg),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
    } else {
      jsonResponse = json.decode(response.body);
      final snackBar = SnackBar(
        content: Text(jsonResponse.toString()),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }
}
