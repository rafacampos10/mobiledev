import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {

  final Function(String) onChanged;
  final String label;
  final bool obscureText;

  const CustomTextFieldWidget({
    Key? key, required this.onChanged,
    required this.label,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle (
          color: Colors.white
      ),
      decoration: InputDecoration(
        label: Text (
            label
        ),
        labelStyle: TextStyle(
          color: Colors.white
        ),
      ),
      onChanged: onChanged,
      obscureText: obscureText,
    );
  }
}
