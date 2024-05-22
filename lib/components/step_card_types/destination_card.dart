import 'package:application/models/place.dart';
import 'package:application/utils/shorten.dart';
import 'package:application/utils/vars.dart';
import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  final Place? destination;
  const DestinationCard({this.destination, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
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
              destination?.secondaryText != ''
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          destination?.mainText ?? '',
                          style: const TextStyle(
                              fontSize: 18, fontFamily: "UberMoveBold"),
                        ),
                        Text(
                          shorten(destination?.secondaryText ?? '', 35),
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "UberMoveMedium",
                              color: darkGrey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Destination',
                          style: TextStyle(
                              fontSize: 18, fontFamily: "UberMoveBold"),
                        ),
                        Text(
                          destination?.mainText ?? '',
                          style: const TextStyle(
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
      ),
    );
  }
}
