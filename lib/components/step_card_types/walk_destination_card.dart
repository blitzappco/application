import 'package:application/utils/vars.dart';
import 'package:flutter/material.dart';

class WalkDestination extends StatelessWidget {
  final int distance;
  final int duration;
  const WalkDestination(
      {required this.distance, required this.duration, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(Icons.directions_walk, size: 35),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Walk to Destination",
                    style: TextStyle(fontSize: 18, fontFamily: "UberMoveBold"),
                  ),
                  Text(
                    "$distance m, $duration min",
                    style: const TextStyle(
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
