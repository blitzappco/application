import 'package:blitz/components/step_card_types/change_platform_card.dart';
import 'package:blitz/components/step_card_types/destination_card.dart';
import 'package:blitz/components/step_card_types/exit_station_card.dart';
import 'package:blitz/components/step_card_types/go_station_card.dart';
import 'package:blitz/components/step_card_types/transit_card.dart';
import 'package:blitz/components/step_card_types/walk_destination_card.dart';
import 'package:blitz/components/step_card_types/walk_directions_card.dart';
import 'package:blitz/components/step_card_types/walk_station_card.dart';
import 'package:blitz/bifrost/core/models/place.dart';
import 'package:blitz/bifrost/core/models/route.dart';
import 'package:blitz/utils/normalize.dart';
import 'package:flutter/material.dart';

class StepCard extends StatelessWidget {
  final String type;

  final TransitDetails? transitDetails;

  final String? direction;

  final int distance;
  final int duration;

  final Place? destination;
  final String? instructions;

  const StepCard({
    required this.type,
    this.transitDetails,
    this.direction,
    required this.distance,
    required this.duration,
    this.destination,
    this.instructions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'go_station':
        return GoStationCard(
          line: transitDetails?.line ?? Line.fromEmpty(),
          headsign: transitDetails?.headsign ?? '',
        );
      case 'exit_station':
        return ExitStation(
          direction: direction ?? '',
        );
      case 'change_platform':
        return ChangePlatform(
          line: transitDetails?.line ?? Line.fromEmpty(),
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
      case 'walk_directions':
        return WalkDirectionsCard(
            duration: duration,
            distance: distance,
            instructions: normalizeInstructions(instructions ?? ''));
      default:
        return GoStationCard(
          line: transitDetails?.line ?? Line.fromEmpty(),
          headsign: transitDetails?.headsign ?? '',
        );
    }
  }
}
