import 'dart:convert';
import 'dart:developer';

import 'package:blitz/bifrost/core/models/route.dart';
import 'package:blitz/bifrost/core/models/place.dart';
import 'package:http/http.dart' as http;
import '../url.dart';

Future<List<Route>> getItineraries(String from, String to) async {
  final url = '$coreURL/$coreVersion/itineraries'
      '?from=$from&to=$to&time=${(DateTime.now().millisecondsSinceEpoch / 1000).round()}';

  // print("TIMESTAMP: ${DateTime.now().millisecondsSinceEpoch / 1000}");

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    inspect(data);

    List<Route> routes = [];

    if (data['routes'].isEmpty) {
      return routes;
    }

    for (int i = 0; i < data['routes'].length; i++) {
      if (data['routes'][i]['legs'][0]['steps'].length != 1) {
        routes.add(Route.fromJSON(data['routes'][i]));
      }
    }

    return routes;
  } else {
    throw Exception('Failed to fetch routes');
  }
}

Future<Place> geocodeFromLatLng(double lat, double lng) async {
  final url = '$coreURL/$coreVersion/geocode'
      '?latlng=$lat,$lng';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    var place = Place.fromGeocode(data['results'][0]);

    return place;
  } else {
    throw Exception('Failed to fetch place');
  }
}

Future<Place> geocodeFromAddress(String address) async {
  final url = '$coreURL/$coreVersion/geocode-reverse'
      '?address=$address';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    var place = Place.fromGeocode(data['results'][0]);

    return place;
  } else {
    throw Exception('Failed to fetch place');
  }
}

Future<Place> geocodeFromPlaceID(String placeID) async {
  final url = '$coreURL/$coreVersion/geocode-reverse'
      '?place_id=$placeID';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    var place = Place.fromGeocode(data['results'][0]);

    return place;
  } else {
    throw Exception('Failed to fetch place');
  }
}

Future<List<Place>> getSearch(String q) async {
  final url = '$coreURL/$coreVersion/search'
      '?q=$q';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Place> places = [];
    for (int i = 0; i < data['predictions'].length; i++) {
      places.add(Place.fromPrediction(data['predictions'][i]));
    }

    return places;
  } else {
    throw Exception('Failed to fetch routes');
  }
}
