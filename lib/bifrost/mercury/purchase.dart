import 'dart:convert';

import 'package:blitz/bifrost/url.dart';
import 'package:http/http.dart' as http;

Future<dynamic> postPurchase(String token, String typeID, String name) async {
  final response =
      await http.post(Uri.parse('$mercuryURL/$mercuryVersion/purchase'),
          headers: authHeader(token),
          body: jsonEncode(<String, String>{
            "typeID": typeID,
            "name": name,
          }));

  final body = jsonDecode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> postPurchasePayment(
  String token,
  int paymentMethod,
  int amount,
) async {
  final response =
      await http.post(Uri.parse('$mercuryURL/$mercuryVersion/purchase/payment'),
          headers: authHeader(token),
          body: jsonEncode(<String, int>{
            "paymentMethod": paymentMethod,
            "amount": amount,
          }));

  final body = jsonDecode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> postPurchaseAttach(
    String token, String paymentIntent, String ticketID) async {
  final response =
      await http.post(Uri.parse('$mercuryURL/$mercuryVersion/purchase/attach'),
          headers: authHeader(token),
          body: jsonEncode(<String, String>{
            "paymentIntent": paymentIntent,
            "ticketID": ticketID,
          }));

  final body = jsonDecode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> deletePurchase(String token, String ticketID) async {
  final response =
      await http.delete(Uri.parse('$mercuryURL/$mercuryVersion/purchase'),
          headers: authHeader(token),
          body: jsonEncode(<String, String>{
            "ticketID": ticketID,
          }));

  final body = jsonDecode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}
