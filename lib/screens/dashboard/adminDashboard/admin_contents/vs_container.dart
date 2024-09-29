import 'package:flutter/material.dart';

class vsContainer extends StatelessWidget {
  final String label;
  final Widget child;

  vsContainer({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.green)),
      height: 400,
      width: 500,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
