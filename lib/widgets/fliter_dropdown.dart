import 'package:flutter/material.dart';

class FliterDropdown extends StatefulWidget {
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String> onChanged;
  final String hint;

  const FliterDropdown({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.hint = 'Select an option',
  }) : super(key: key);

  @override
  State<FliterDropdown> createState() => _FliterDropdownState();
}

class _FliterDropdownState extends State<FliterDropdown> {
  late String currentItem;

  @override
  void initState() {
    super.initState();
    currentItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentItem,
      hint: Text(widget.hint),
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
      ),
      onChanged: (String? newValue) {
        setState(() {
          currentItem = newValue!;
          widget.onChanged(currentItem);
        });
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
