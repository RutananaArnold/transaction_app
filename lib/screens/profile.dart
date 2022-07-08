import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/user_profile.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchUsers();
  }

  Future<UserProfile> fetchUsers() async {
    final response =
        await http.get(Uri.parse("http://" + apiUrl + "/fetch/userProfile/12"));
    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user_profile');
      // return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: FutureBuilder<UserProfile>(
      future: fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.blue[200],
                child: const Icon(
                  Icons.person,
                  size: 100,
                ),
              ),
              const SizedBox(height: 80),
              const Text(
                "USERNAME:",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                ),
              ),
              Center(
                child: Text(
                  snapshot.data!.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),
              ),
              const Text(
                "EMAIL:",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    snapshot.data!.email,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          );
        }
        // else if (snapshot.hasError) {
        //   return Text('${snapshot.error}');
        // }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    )));
  }
}
