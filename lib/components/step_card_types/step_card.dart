import 'package:application/components/step_card_types/change_platform_card.dart';
import 'package:application/components/step_card_types/destination_card.dart';
import 'package:application/components/step_card_types/exit_station_card.dart';
import 'package:application/components/step_card_types/go_station_card.dart';
import 'package:application/components/step_card_types/walk_destination_card.dart';
import 'package:application/components/step_card_types/walk_station_card.dart';
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
        return GoStationCard(
          vehicle: vehicle,
          vehicle_dest: vehicle_dest,
        );
      case 'exit_station':
        return ExitStation(
          direction: direction,
        );
      case 'change_platform':
        return ChangePlatform(
          vehicle: vehicle,
          vehicle_dest: vehicle_dest,
        );
      case 'walk_destination':
        return WalkDestination(
          distance: distance,
          minutes: minutes,
        );
      case 'walk_station':
        return WalkStation(
          distance: distance,
          minutes: minutes,
        );
      case 'destination':
        return DestinationCard(
          address: address,
        );
      default:
        return GoStationCard(
          vehicle: vehicle,
          vehicle_dest: vehicle_dest,
        );
    }
  }
}
