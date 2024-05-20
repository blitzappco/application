import 'package:application/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/env.dart';

Future<List<Place>> getPredictions(String input) async {
  final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?language=en'
      '&input=$input'
      // '&locationbias'
      '&key=$mapKey';

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