import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool autocorrect;
  final AutovalidateMode autovalidateMode;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final bool hasBottomBorder; // New parameter to control bottom border

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.autocorrect = false,
    this.autovalidateMode = AutovalidateMode.disabled,
    required this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hasBottomBorder = false, // Default value is false
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      autovalidateMode: widget.autovalidateMode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        border: widget.hasBottomBorder
            ? const UnderlineInputBorder() // Shows only the bottom border
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
      validator: widget.validator,
    );
  }
}
