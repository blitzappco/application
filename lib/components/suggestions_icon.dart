import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

class SuggestionsIcon extends StatelessWidget {
  final String type;
  final String name;
  const SuggestionsIcon({super.key, required this.type, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: placeColors[type]),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                placeIcons[type],
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: const TextStyle(
                fontFamily: "UberMoveMedium", color: darkGrey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
