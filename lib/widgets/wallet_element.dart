import 'package:flutter/material.dart';

class WalletElement extends StatelessWidget {
  String label;
  VoidCallback tap;
  IconData icon;
  WalletElement(
      {Key? key, required this.label, required this.tap, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: tap, icon: Icon(icon, color: Colors.white, size: 30)),
          Text(
            label,
            style: const TextStyle(
                color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
