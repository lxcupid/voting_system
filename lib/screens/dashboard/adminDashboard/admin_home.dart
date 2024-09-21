import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Text('Home'),
          Container(
            height: 2000,
            width: double.infinity,
            color: const Color.fromARGB(255, 41, 162, 100),
          )
        ],
      ),
    ));
  }
}
