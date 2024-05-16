import 'package:application/components/step_card_types/go_station_card.dart';
import 'package:flutter/material.dart';

class StepCard extends StatelessWidget {
  final String type;
  final String vehicle;
  final String vehicle_dest;
  final String direction;
  final int distance;
  final int minutes;
  final String address;

  const StepCard({
    required this.type,
    required this.vehicle,
    required this.vehicle_dest,
    required this.direction,
    required this.distance,
    required this.minutes,
    required this.address,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'go_station':
        return GoStationCard();

      default:
        return GoStationCard();
    }
  }
}
