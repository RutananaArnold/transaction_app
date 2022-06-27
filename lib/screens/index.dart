import 'package:flutter/material.dart';
import 'package:transaction_app/screens/user1.dart';
import 'package:transaction_app/screens/user2.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int selectedTabIndex = 0;

  void onItemTapped(index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  List<Widget> tabs = [User1(), User2()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "User 1",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: "User 2",
              backgroundColor: Colors.deepPurple[300]),
        ],
        onTap: onItemTapped,
        currentIndex: selectedTabIndex,
        selectedItemColor: Colors.red,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
