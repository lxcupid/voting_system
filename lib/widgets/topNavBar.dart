import 'package:flutter/material.dart';

class Topnavbar extends StatelessWidget {
  final String centerText;

  const Topnavbar({super.key, required this.centerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.green.shade300,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10,
          ),
          Text(
            centerText,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          ClipOval(
            child: Container(
              color: Colors.white,
              height: 60,
              width: 60,
              child: Image.asset(
                'icons/plsp_logo.png', // Update with your logo path
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
