import 'package:google_maps_flutter/google_maps_flutter.dart';

class Route {
  Bounds bounds;
  Leg leg;

  Route({
    required this.bounds,
    required this.leg,
  });

  factory Route.fromJSON(Map<String, dynamic> json) {
    return Route(
      bounds: Bounds.fromJSON(json['bounds']),
      leg: Leg.fromJSON(json['legs'][0]),
    );
  }
}

class Bounds {
  LatLng northEast;
  LatLng southWest;

  Bounds({
    required this.northEast,
    required this.southWest,
  });

  factory Bounds.fromJSON(Map<String, dynamic> json) {
    return Bounds(
      northEast: LatLng(json['northeast']['lat'], json['northeast']['lng']),
      southWest: LatLng(json['southwest']['lat'], json['southwest']['lng']),
    );
  }
}

class Leg {
  Field? departureTime;
  Field? arrivalTime;
  String travelMode;

  Field distance;
  Field duration;

  String startAddress;
  LatLng startLocation;
  String endAddress;
  LatLng endLocation;

  List<Step> steps;
  List<StepWalking> stepsWalking;

  Leg(
      {this.departureTime,
      this.arrivalTime,
      required this.travelMode,
      required this.distance,
      required this.duration,
      required this.startAddress,
      required this.startLocation,
      required this.endAddress,
      required this.endLocation,
      required this.steps,
      required this.stepsWalking});

  factory Leg.fromJSON(Map<String, dynamic> json) {
    String mode;
    if (json.containsKey('arrival_time')) {
      mode = 'TRANSIT';
    } else {
      mode = 'WALKING';
    }
    List<Step> stepsList = [];
    List<StepWalking> stepsWalkingList = [];
    if (mode == 'TRANSIT') {
      for (int i = 0; i < json['steps'].length; i++) {
        stepsList.add(Step.fromJSON(json['steps'][i]));
      }
    } else {
      for (int i = 0; i < json['steps'].length; i++) {
        stepsWalkingList.add(StepWalking.fromJSON(json['steps'][i]));
      }
    }

    return Leg(
      travelMode: mode,
      arrivalTime: mode == 'TRANSIT'
          ? Field.fromJSON(json['arrival_time'])
          : Field.fromEmpty(),
      departureTime: mode == 'TRANSIT'
          ? Field.fromJSON(json['departure_time'] ?? false)
          : Field.fromEmpty(),
      distance: Field.fromJSON(json['distance']),
      duration: Field.fromJSON(json['duration']),
      startAddress: json['start_address'],
      startLocation:
          LatLng(json['start_location']['lat'], json['start_location']['lng']),
      endAddress: json['end_address'],
      endLocation:
          LatLng(json['end_location']['lat'], json['end_location']['lng']),
      steps: stepsList,
      stepsWalking: stepsWalkingList,
    );
  }
}

class Step {
  Field distance;
  Field duration;

  LatLng endLocation;
  LatLng startLocation;

  String instructions;

  List<StepWalking>? walkingSteps;
  TransitDetails? transitDetails;

  String polyline;

  String travelMode;

  Step({
    required this.distance,
    required this.duration,
    required this.startLocation,
    required this.endLocation,
    required this.instructions,
    required this.polyline,
    this.walkingSteps,
    this.transitDetails,
    required this.travelMode,
  });

  factory Step.fromJSON(Map<String, dynamic> json) {
    TransitDetails? td;
    List<StepWalking>? ws = [];

    if (json['travel_mode'] == "WALKING") {
      for (int i = 0; i < json['steps'].length; i++) {
        ws.add(StepWalking.fromJSON(json['steps'][i]));
      }
    } else if (json['travel_mode'] == "TRANSIT") {
      td = TransitDetails.fromJSON(json['transit_details']);
    }

    return Step(
      distance: Field.fromJSON(json['distance']),
      duration: Field.fromJSON(json['duration']),
      startLocation:
          LatLng(json['start_location']['lat'], json['start_location']['lng']),
      endLocation:
          LatLng(json['end_location']['lat'], json['end_location']['lng']),
      instructions: json['html_instructions'],
      polyline: json['polyline']['points'],
      transitDetails: td,
      walkingSteps: ws,
      travelMode: json['travel_mode'],
    );
  }
}

class StepWalking {
  Field distance;
  Field duration;

  LatLng endLocation;
  LatLng startLocation;

  String instructions;

  String polyline;

  StepWalking({
    required this.distance,
    required this.duration,
    required this.startLocation,
    required this.endLocation,
    required this.instructions,
    required this.polyline,
  });

  factory StepWalking.fromJSON(Map<String, dynamic> json) {
    return StepWalking(
        distance: Field.fromJSON(json['distance']),
        duration: Field.fromJSON(json['duration']),
        startLocation: LatLng(
            json['start_location']['lat'], json['start_location']['lng']),
        endLocation:
            LatLng(json['end_location']['lat'], json['end_location']['lng']),
        instructions: json['html_instructions'] ?? '',
        polyline: json['polyline']['points']);
  }
}

class TransitDetails {
  Stop departureStop;
  Field departureTime;

  Stop arrivalStop;
  Field arrivalTime;

  String headsign;
  int numStops;

  Line line;

  TransitDetails({
    required this.departureStop,
    required this.departureTime,
    required this.arrivalStop,
    required this.arrivalTime,
    required this.headsign,
    required this.numStops,
    required this.line,
  });

  factory TransitDetails.fromJSON(Map<String, dynamic> json) {
    return TransitDetails(
      departureStop: Stop.fromJSON(json['departure_stop']),
      departureTime: Field.fromJSON(json['departure_time']),
      arrivalStop: Stop.fromJSON(json['arrival_stop']),
      arrivalTime: Field.fromJSON(json['arrival_time']),
      headsign: json['headsign'],
      numStops: json['num_stops'],
      line: Line.fromJSON(json['line']),
    );
  }
}

class Stop {
  LatLng location;
  String name;

  Stop({
    required this.location,
    required this.name,
  });

  factory Stop.fromJSON(Map<String, dynamic> json) {
    return Stop(
      location: LatLng(json['location']['lat'], json['location']['lng']),
      name: json['name'],
    );
  }
}

class Line {
  String color;
  String name;
  String vehicleType;

  Line({
    required this.color,
    required this.name,
    required this.vehicleType,
  });

  factory Line.fromJSON(Map<String, dynamic> json) {
    return Line(
      color: json['color'],
      name: json['short_name'],
      vehicleType: json['vehicle']['type'] == "TROLLEYBUS"
          ? "TROLLEY"
          : json['vehicle']['type'],
    );
  }

  factory Line.fromEmpty() {
    return Line(color: '', name: '', vehicleType: '');
  }
}

class Field {
  String text;
  int value;

  Field({
    required this.text,
    required this.value,
  });

  factory Field.fromJSON(dynamic json) {
    return Field(
      text: json['text'],
      value: json['value'],
    );
  }

  factory Field.fromEmpty() {
    return Field(text: "NOOOOOOO", value: 123456);
  }
}
