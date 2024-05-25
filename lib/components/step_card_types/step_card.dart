import 'package:application/components/step_card_types/change_platform_card.dart';
import 'package:application/components/step_card_types/destination_card.dart';
import 'package:application/components/step_card_types/exit_station_card.dart';
import 'package:application/components/step_card_types/go_station_card.dart';
import 'package:application/components/step_card_types/transit_card.dart';
import 'package:application/components/step_card_types/walk_destination_card.dart';
import 'package:application/components/step_card_types/walk_station_card.dart';
import 'package:application/models/place.dart';
import 'package:application/models/route.dart';
import 'package:flutter/material.dart';

class StepCard extends StatelessWidget {
  final String type;

  final TransitDetails? transitDetails;

  final String? direction;

  final int distance;
  final int duration;

  final Place? destination;

  const StepCard({
    required this.type,
    this.transitDetails,
    this.direction,
    required this.distance,
    required this.duration,
    this.destination,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'go_station':
        return GoStationCard(
          line: transitDetails?.line ?? Line.empty(),
          headsign: transitDetails?.headsign ?? '',
        );
      case 'exit_station':
        return ExitStation(
          direction: direction ?? '',
        );
      case 'change_platform':
        return ChangePlatform(
          line: transitDetails?.line ?? Line.empty(),
          headsign: transitDetails?.headsign ?? '',
        );
      case 'walk_destination':
        return WalkDestination(
          distance: distance,
          duration: duration,
        );
      case 'walk_station':
        return WalkStation(
          distance: distance,
          duration: duration,
        );
      case 'destination':
        return DestinationCard(
          destination: destination,
        );
      case 'transit':
        return TransitCard(
          transitDetails: transitDetails,
          duration: duration,
        );
      default:
        return GoStationCard(
          line: transitDetails?.line ?? Line.empty(),
          headsign: transitDetails?.headsign ?? '',
        );
    }
  }
}
