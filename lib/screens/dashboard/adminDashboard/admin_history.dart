import 'package:flutter/material.dart';

class AdminHistory extends StatelessWidget {
  const AdminHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Text('History'),
          Container(
            height: 2000,
            width: double.infinity,
            color: const Color.fromARGB(255, 0, 0, 0),
          )
        ],
      ),
    ));
  }
}
