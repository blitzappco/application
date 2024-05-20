import 'package:application/models/route.dart';
import 'package:application/utils/polyline.dart';
import 'package:flutter/material.dart';
import '../utils/vars.dart';

class LineShorthand extends StatelessWidget {
  final Line line;
  const LineShorthand({required this.line, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: convertHex(line.color),
          borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          children: [
            if (line.vehicleType != "SUBWAY")
              Icon(
                lineIcons[line.vehicleType],
                color: Colors.white,
                size: 18,
              ),
            Text(
              line.name,
              style: const TextStyle(
                  fontFamily: 'UberMoveBold',
                  color: Colors.white,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
