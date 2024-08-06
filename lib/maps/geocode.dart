import 'package:blitz/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Place> fetchAddressFromPlace(String placeID) async {
  String? mapsKey = dotenv.env['MAPS_KEY'];
  final url = 'https://maps.googleapis.com/maps/api/geocode/json'
      '?language=en'
      '&place_id=$placeID'
      // '&locationbias'
      '&key=$mapsKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    var place = Place.fromGeocode(data['results'][0]);

    return place;
  } else {
    throw Exception('Failed to fetch place');
  }
}

Future<Place> fetchPlaceFromLatLng(double lat, double lng) async {
  String? mapsKey = dotenv.env['MAPS_KEY'];
  final url = 'https://maps.googleapis.com/maps/api/geocode/json'
      '?language=en'
      '&latlng=$lat,$lng'
      // '&locationbias'
      '&key=$mapsKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    var place = Place.fromGeocode(data['results'][0]);

    return place;
  } else {
    throw Exception('Failed to fetch place');
  }
}

Future<Place> fetchPlaceFromAddress(String address) async {
  String? mapsKey = dotenv.env['MAPS_KEY'];
  final url = 'https://maps.googleapis.com/maps/api/geocode/json'
      '?language=en'
      '&address=$address'
      // '&locationbias'
      '&key=$mapsKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    var place = Place.fromGeocode(data['results'][0]);

    return place;
  } else {
    throw Exception('Failed to fetch place');
  }
}
