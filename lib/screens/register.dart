import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:transaction_app/screens/index.dart';
import 'package:transaction_app/widgets/rounded_button.dart';
import 'package:transaction_app/widgets/rounded_input_field.dart';
import 'package:transaction_app/widgets/rounded_password_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/user_id.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.3,
                child: const CircleAvatar(
                  radius: 80,
                  child: Icon(
                    Icons.person_add_alt,
                    size: 70,
                  ),
                ),
              ),
              RoundedInputField(
                  hintText: "NAME",
                  icon: Icons.person,
                  controller: nameController),
              RoundedInputField(
                  hintText: "EMAIL",
                  icon: Icons.email,
                  controller: emailController),
              RoundedPasswordField(
                  hintText: "PASSWORD", controller: passwordController),
              RoundedButton(
                  text: "registered",
                  press: () {
                    registration(nameController.text, emailController.text,
                        passwordController.text);
                  },
                  color: Color.fromARGB(255, 118, 224, 120))
            ],
          ),
        ),
      )),
    );
  }

  // registration logic
  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };

  registration(String name, String email, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
    };
    print(data);
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    var jsonResponse;

    var response = await http.post(
      Uri.parse("http://" + apiUrl + "/register/user"),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    if (response.statusCode == 200) {
      jsonResponse = IdUser.fromJson(jsonDecode(response.body));
      print(jsonResponse.userId);
      if (jsonResponse != null) {
        // Save an integer value to 'userId' key.
        await prefs.setInt('userId', jsonResponse.userId);
        const snackBar = SnackBar(
          content: Text('Fully Registered enjoy!'),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Index(),
            ),
            (route) => false);
      }
    } else {
      jsonResponse = json.decode(response.body);
    }
  }
}
