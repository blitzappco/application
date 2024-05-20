import 'package:flutter/material.dart';

class TextFieldBox extends StatefulWidget {
  final TextEditingController controller;
  const TextFieldBox({required this.controller, super.key});

  @override
  State<TextFieldBox> createState() => _TextFieldBoxState();
}

class _TextFieldBoxState extends State<TextFieldBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          keyboardType: TextInputType.phone,
          //must add controller
          controller: widget.controller,
          cursorColor: Colors.black,
          style: const TextStyle(fontSize: 22, fontFamily: 'UberMoveMedium'),
          decoration: InputDecoration(
            prefixIcon: const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  '+4',
                  style: TextStyle(fontSize: 22, fontFamily: 'UberMoveMedium'),
                )),
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
