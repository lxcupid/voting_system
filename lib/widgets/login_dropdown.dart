import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final String hintText;
  final Color? backgroundColor;
  final String? selectedValue;
  final Function(String?)? onChanged;
  final double borderRadius;
  final TextStyle? textStyle;

  const CustomDropdown({
    Key? key,
    required this.options,
    required this.hintText,
    this.selectedValue,
    this.onChanged,
    this.borderRadius = 8.0,
    this.textStyle,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        color: widget.backgroundColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedValue,
          hint: Text(widget.hintText),
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          style: widget.textStyle ?? TextStyle(color: Colors.black),
          items: widget.options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
        ),
      ),
    );
  }
}
