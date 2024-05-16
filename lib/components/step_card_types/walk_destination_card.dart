import 'package:application/utils/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalkDestination extends StatelessWidget {
  final int distance;
  final int minutes;
  const WalkDestination(
      {required this.distance, required this.minutes, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.directions_walk, size: 35),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Walk to Destination",
                    style: TextStyle(fontSize: 18, fontFamily: "UberMoveBold"),
                  ),
                  Text(
                    "$distance m, $minutes min",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "UberMoveMedium",
                        color: darkGrey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
