import 'package:flutter/material.dart';

class TextField extends StatelessWidget {
  final String text;
  final TextInputType type;
  final TextEditingController controller;
  const TextField(
      {required this.text,
      required this.type,
      required this.controller,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontFamily: "SFProRounded", fontSize: 18),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Colors.grey[300], // Change to the appropriate color
        labelText: text,
        labelStyle: const TextStyle(
          fontFamily: "SFProRounded",
          fontWeight: FontWeight.w500,
        ),
      ),
      keyboardType: type,
    );
  }
}
