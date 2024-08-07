import 'dart:convert';

import 'package:blitz/bifrost/url.dart';
import 'package:http/http.dart' as http;

Future<dynamic> fetchPaymentMethods(String token) async {
  final response = await http.get(
    Uri.parse('$mantleURL/$mantleVersion/payment-methods'),
    headers: authHeader(token),
  );

  final body = jsonDecode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}
