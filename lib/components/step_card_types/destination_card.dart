import 'package:application/utils/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  final String address;
  const DestinationCard({required this.address, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.directions_walk,
                  size: 20,
                  color: Colors.white,
                ),
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Destination",
                  style: TextStyle(fontSize: 18, fontFamily: "UberMoveBold"),
                ),
                Text(
                  address,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "UberMoveMedium",
                      color: darkGrey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
