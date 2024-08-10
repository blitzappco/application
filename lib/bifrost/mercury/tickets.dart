import 'package:blitz/bifrost/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> postValidateTicket(String token, String ticketID) async {
  final response = await http.post(
    Uri.parse(
        '$mercuryURL/$mercuryVersion/tickets/validate?ticketID=$ticketID'),
    headers: authHeader(token),
  );

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> fetchTicketTypes(String token, String city) async {
  final response = await http.get(
    Uri.parse('$mercuryURL/$mercuryVersion/tickets/types?city=$city'),
    headers: authHeader(token),
  );

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> fetchTicket(String token, String ticketID) async {
  final response = await http.get(
    Uri.parse('$mercuryURL/$mercuryVersion/tickets/ticket?ticketID=$ticketID'),
    headers: authHeader(token),
  );

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> fetchTickets(String token) async {
  final response = await http.get(
    Uri.parse('$mercuryURL/$mercuryVersion/tickets'),
    headers: authHeader(token),
  );

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> fetchLastTicket(String token, String city) async {
  final response = await http.get(
    Uri.parse('$mercuryURL/$mercuryVersion/tickets/last?city=$city'),
    headers: authHeader(token),
  );

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}
