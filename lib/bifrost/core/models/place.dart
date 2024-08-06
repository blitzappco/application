import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  String placeID;

  String mainText;
  String? secondaryText;

  List<String> types;

  LatLng? location;

  Place({
    required this.placeID,
    required this.mainText,
    this.secondaryText,
    required this.types,
    this.location,
  });

  factory Place.fromPrediction(Map<String, dynamic> json) {
    List<String> ts = [];
    for (int i = 0; i < json['types'].length; i++) {
      ts.add(json['types'][i]);
    }
    return Place(
      placeID: json['place_id'],
      mainText: json['structured_formatting']['main_text'],
      secondaryText: json['structured_formatting']['secondary_text'],
      types: ts,
    );
  }

  factory Place.fromGeocode(Map<String, dynamic> json) {
    List<String> ts = [];
    for (int i = 0; i < json['types'].length; i++) {
      ts.add(json['types'][i]);
    }
    return Place(
      placeID: json['place_id'],
      mainText: json['formatted_address'],
      location: LatLng(
        json['geometry']['location']['lat'],
        json['geometry']['location']['lng'],
      ),
      types: ts,
    );
  }

  factory Place.fromTrip(Map<String, dynamic> json) {
    return Place(
        placeID: json['placeID'],
        mainText: json['mainText'],
        secondaryText: json['secondaryText'],
        types: [json['type']]);
  }
}
