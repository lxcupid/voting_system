import 'package:flutter/material.dart';

class VotinsystemVotingLine extends StatefulWidget {
  const VotinsystemVotingLine({super.key});

  @override
  State<VotinsystemVotingLine> createState() => _VotinsystemVotingLineState();
}

class _VotinsystemVotingLineState extends State<VotinsystemVotingLine> {
  String? selectedValue; // Use String? to allow null value initially

  final List<String> options = [
    'College of Computer Study and Technology',
    'College of Engineering',
    'College of Tourism and Hospitality Management',
    'College of Accountancy'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(top: 10, right: 10),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: IntrinsicWidth(
                // Add IntrinsicWidth to make the container size fit its child
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedValue, // Currently selected filter value
                    hint: Text('Select Election'),
                    isExpanded:
                        false, // Set this to false to avoid forcing full width
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    items: options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue =
                            newValue; // Update the selected filter value
                        print(selectedValue);
                      });
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
