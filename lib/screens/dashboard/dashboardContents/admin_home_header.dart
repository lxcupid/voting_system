import 'package:flutter/material.dart';

class AdminHomeHeader extends StatefulWidget {
  final VoidCallback onMenuPressed;
  final String user;

  const AdminHomeHeader(
      {super.key, required this.onMenuPressed, required this.user});

  @override
  State<AdminHomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<AdminHomeHeader> {
  String studentID = '474151';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      height: 60,
      child: Row(
        children: [
          // Menu Icon to collapse/expand the drawer
          IconButton(
            icon: const Icon(
              Icons.menu,
              size: 30,
              color: Colors.white,
            ),
            onPressed: widget.onMenuPressed, // Trigger the drawer toggle
          ),
          const SizedBox(width: 10),
          Text(
            'Hi! ${widget.user} ${studentID}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
