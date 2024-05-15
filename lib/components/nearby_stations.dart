import 'package:application/components/station_card.dart';
import 'package:flutter/material.dart';

class NearbyStations extends StatelessWidget {
  const NearbyStations({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return StationCard(
            stationDistance: '100 meters',
            stationName: 'Piata Operei',
            Shorthand1: '104',
            Shorthand2: '35',
          );
        },
      ),
    );
  }
}
