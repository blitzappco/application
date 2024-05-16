import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String ButtonText;
  final IconData ButtonIcon;
  const ProfileButton(
      {required this.ButtonIcon, required this.ButtonText, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              width: 1,
              color: const Color.fromARGB(255, 172, 172, 172),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            children: [
              Icon(
                ButtonIcon,
                size: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                ButtonText,
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
