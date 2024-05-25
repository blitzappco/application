import 'package:blitz/models/route.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/env.dart';

Future<List<Route>> fetchRoutes(String from, String to) async {
  final url = 'https://maps.googleapis.com/maps/api/directions/json'
      '?language=en'
      '&mode=transit&alternatives=true'
      '&origin=$from&destination=$to&key=$mapKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Route> routes = [];
    for (int i = 0; i < data['routes'].length; i++) {
      routes.add(Route.fromJSON(data['routes'][i]));
    }

    return routes;
  } else {
    throw Exception('Failed to fetch routes');
  }
}
