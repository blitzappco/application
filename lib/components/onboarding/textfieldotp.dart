import 'package:flutter/material.dart';

class TextFieldBoxOTP extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  const TextFieldBoxOTP({
    super.key,
    required this.controller,
    required this.keyboardType,
  });

  @override
  State<TextFieldBoxOTP> createState() => _TextFieldBoxOTPState();
}

class _TextFieldBoxOTPState extends State<TextFieldBoxOTP> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          //must add controller
          cursorColor: Colors.black,
          style: const TextStyle(fontSize: 22, fontFamily: 'UberMoveMedium'),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            fillColor: const Color(0xFFE8E8E8),
            filled: true,
          ),
        ),
      ],
    );
  }
}
