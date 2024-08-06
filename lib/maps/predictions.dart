import 'package:blitz/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Place>> fetchPredictions(String input) async {
  String? mapsKey = dotenv.env['MAPS_KEY'];
  final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?language=en'
      '&input=$input'
      '&locationbias=circle:5000@44.4379187,26.0122375'
      '&key=$mapsKey';

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
