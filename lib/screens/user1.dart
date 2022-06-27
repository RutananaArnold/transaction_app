// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:transaction_app/widgets/wallet_element.dart';

class User1 extends StatefulWidget {
  User1({Key? key}) : super(key: key);

  @override
  State<User1> createState() => _User1State();
}

class _User1State extends State<User1> {
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
                            tap: () {}),
                            
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

  topup_request(int amount){
    
  }
}
