import 'package:flutter/material.dart';

class AdminColleges extends StatelessWidget {
  const AdminColleges({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Text('College'),
          Container(
            height: 2000,
            width: double.infinity,
            color: const Color.fromARGB(255, 98, 66, 63),
          )
        ],
      ),
    ));
  }
}
