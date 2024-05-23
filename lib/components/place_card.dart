import 'package:application/utils/types.dart';
import 'package:application/utils/vars.dart';
import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String mainText;
  final String secondaryText;
  final String type;
  final Future<void> Function() callback;
  const PlaceCard({
    required this.mainText,
    required this.secondaryText,
    required this.type,
    required this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.amber,
            ),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Icon(
                mapPlaceIcons[type],
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
                mainText,
                style: TextStyle(fontSize: 16, fontFamily: 'UberMoveBold'),
              ),
              Text(
                secondaryText,
                style: TextStyle(fontSize: 14, fontFamily: 'UberMoveMedium'),
              )
            ],
          )
        ],
      ),
    );
  }
}
