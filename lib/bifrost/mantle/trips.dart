import 'dart:convert';

import 'package:blitz/bifrost/core/models/place.dart';
import 'package:blitz/bifrost/url.dart';
import 'package:http/http.dart' as http;

Future<dynamic> fetchTrips(String token) async {
  final response = await http.get(
    Uri.parse('$mantleURL/$mantleVersion/trips'),
    headers: authHeader(token),
  );

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> postTrip(String token, Place trip) async {
  final response = await http.post(Uri.parse('$mantleURL/$mantleVersion/trips'),
      headers: authHeader(token), body: jsonEncode(trip.toJSON()));

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}
