import 'package:flutter/material.dart';

class Shorthand extends StatelessWidget {
  final String lineNumber;
  final Color lineColor;
  final String lineType;
  const Shorthand({
    required this.lineNumber,
    required this.lineColor,
    required this.lineType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: lineColor, borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Row(
          children: [
            Icon(
              Icons.directions_bus_rounded,
              size: 15,
              color: Colors.white,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              lineNumber,
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'UberMoveBold',
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
