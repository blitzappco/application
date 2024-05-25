import 'package:application/components/step_card_types/step_card.dart';
import 'package:application/models/place.dart';
import 'package:application/models/route.dart' as route;

List<StepCard> processSteps(List<route.Step> steps, Place destination) {
  List<StepCard> result = [];

  List<route.Step> transitSteps = [];
  int transitSeen = -1;

  for (int i = 0; i < steps.length; i++) {
    if (steps[i].travelMode == "TRANSIT") {
      transitSteps.add(steps[i]);
    }
  }

  for (int i = 0; i < steps.length; i++) {
    var step = steps[i];

    // WALKING
    if (step.travelMode == "WALKING") {
      if (i == steps.length - 1) {
        result.add(StepCard(
          type: 'walk_destination',
          distance: step.distance.value,
          duration: step.duration.value,
        ));
      } else if (transitSeen != -1 &&
          transitSeen != transitSteps.length - 1 &&
          transitSteps[transitSeen].transitDetails?.line.vehicleType ==
              "SUBWAY" &&
          transitSteps[transitSeen + 1].transitDetails?.line.vehicleType ==
              "SUBWAY") {
        result.add(StepCard(
          type: 'change_platform',
          distance: 0,
          duration: 0,
          transitDetails: transitSteps[transitSeen + 1].transitDetails,
        ));
      } else {
        result.add(StepCard(
          type: 'walk_station',
          distance: step.distance.value,
          duration: step.duration.value,
        ));
      }
    }

    // TRANSIT
    if (step.travelMode == "TRANSIT") {
      transitSeen += 1;
      if (step.transitDetails?.line.vehicleType != 'SUBWAY') {
        result.add(StepCard(
          type: 'transit',
          distance: step.distance.value,
          duration: step.duration.value,
          transitDetails: step.transitDetails,
        ));
      } else {
        if (transitSeen == 0 ||
            (transitSeen != 0 &&
                transitSteps[transitSeen - 1]
                        .transitDetails
                        ?.line
                        .vehicleType !=
                    'SUBWAY')) {
          result.add(StepCard(
            type: 'go_station',
            distance: 0,
            duration: 0,
            transitDetails: step.transitDetails,
          ));
          result.add(StepCard(
            type: 'transit',
            distance: step.distance.value,
            duration: step.duration.value,
            transitDetails: step.transitDetails,
          ));
        } else {
          result.add(StepCard(
            type: 'transit',
            distance: step.distance.value,
            duration: step.duration.value,
            transitDetails: step.transitDetails,
          ));

          if (transitSeen == transitSteps.length - 1 ||
              (transitSeen != transitSteps.length - 1 &&
                  transitSteps[transitSeen + 1]
                          .transitDetails
                          ?.line
                          .vehicleType !=
                      'SUBWAY')) {
            result.add(StepCard(
                type: 'exit_station',
                distance: 0,
                duration: step.duration.value,
                direction: 'next point',
                transitDetails: step.transitDetails));
          }
        }
      }
    }
  }

  result.add(StepCard(
    type: 'destination',
    destination: destination,
    distance: 0,
    duration: 0,
  ));
  return result;
}
