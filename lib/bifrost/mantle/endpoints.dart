import 'dart:convert';

import 'package:blitz/bifrost/url.dart';
import 'package:http/http.dart' as http;

Future<dynamic> postOnboarding(String phone) async {
  final response =
      await http.post(Uri.parse('$mantleURL/$mantleVersion/onboarding'),
          headers: basicHeader,
          body: jsonEncode(<String, String>{
            'phone': phone,
          }));

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> postOnboardingCode(
    String token, String code, bool newClient) async {
  final response = await http.post(
      Uri.parse('$mantleURL/$mantleVersion/onboarding/verify-code'),
      headers: authHeader(token),
      body: jsonEncode(<String, dynamic>{
        'code': code,
        'newClient': newClient,
      }));

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> postOnboardingName(
    String token, String firstName, String lastName) async {
  final response =
      await http.post(Uri.parse('$mantleURL/$mantleVersion/onboarding/name'),
          headers: authHeader(token),
          body: jsonEncode(<String, String>{
            "firstName": firstName,
            "lastName": lastName,
          }));

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}
