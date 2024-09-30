import 'package:flutter/material.dart';

class CustomContainerWidget extends StatelessWidget {
  final String positionText;
  final String action1Text;
  final String action2Text;
  final VoidCallback onAction1Tap;
  final VoidCallback onAction2Tap;
  final List<Widget> fields;

  const CustomContainerWidget({
    Key? key,
    required this.positionText,
    required this.action1Text,
    required this.action2Text,
    required this.onAction1Tap,
    required this.onAction2Tap,
    required this.fields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                positionText,
                style:
                    TextStyle(fontFamily: 'Arial', fontWeight: FontWeight.bold),
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: onAction1Tap,
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green[300]),
                        child: Text(
                          action1Text,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: onAction2Tap,
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red[300]),
                        child: Text(action2Text,
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: Column(
              children: fields,
            ),
          ),
        ],
      ),
    );
  }
}
