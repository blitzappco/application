import 'dart:convert';

import 'package:blitz/bifrost/mantle/models/account.dart';
import 'package:blitz/bifrost/url.dart';
import 'package:http/http.dart' as http;

Future<dynamic> fetchLabels(String token) async {
  final response = await http.get(
    Uri.parse('$mantleURL/$mantleVersion/labels'),
    headers: authHeader(token),
  );

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> postLabel(String token, Label label) async {
  final response = await http.post(
      Uri.parse('$mantleURL/$mantleVersion/labels'),
      headers: authHeader(token),
      body: jsonEncode(label.toJSON()));

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> deleteLabel(String token, int index) async {
  final response =
      await http.delete(Uri.parse('$mantleURL/$mantleVersion/labels'),
          headers: authHeader(token),
          body: jsonEncode(<String, int>{
            "index": index,
          }));

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}

Future<dynamic> patchLabel(String token, int index, Label label) async {
  final li = label.toJSON();
  li["index"] = index;

  final response = await http.patch(
      Uri.parse('$mantleURL/$mantleVersion/labels'),
      headers: authHeader(token),
      body: jsonEncode(li));

  final body = json.decode(utf8.decode(response.bodyBytes));
  body["statusCode"] = response.statusCode;

  return body;
}
