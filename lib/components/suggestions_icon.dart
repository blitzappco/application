import 'package:application/utils/vars.dart';
import 'package:flutter/material.dart';

class SuggestionsIcon extends StatelessWidget {
  const SuggestionsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.shopping_bag_rounded,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Drinks",
            style: TextStyle(
                fontFamily: "UberMoveMedium", color: darkGrey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
