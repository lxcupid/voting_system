import 'package:flutter/material.dart';

class DashScreen extends StatelessWidget {
  const DashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Text('DashBoard'),
          Container(
            height: 2000,
            width: double.infinity,
            color: Colors.red,
          )
        ],
      ),
    ));
  }
}
