import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String PlaceName;
  final String PlaceAddrees;
  final Color IconColor;
  const PlaceCard({
    required this.PlaceName,
    required this.PlaceAddrees,
    required this.IconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: IconColor),
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Icon(
              Icons.school_rounded,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              PlaceName,
              style: TextStyle(fontSize: 16, fontFamily: 'UberMoveBold'),
            ),
            Text(
              PlaceAddrees,
              style: TextStyle(fontSize: 14, fontFamily: 'UberMoveMedium'),
            )
          ],
        )
      ],
    );
  }
}
