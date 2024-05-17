import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/account.dart';
import '../utils/url.dart';
import '../utils/preferences.dart';

class AccountProvider with ChangeNotifier {
  String phoneNumber = '';
  String token = '';

  bool newClient = false;

  bool loading = false;
  String errorMessage = '';

  Account account = Account();

  loadAccount() async {
    token = await getToken();
    account = await getAccount();
    notifyListeners();
  }

  setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  onboarding(String phone) async {
    phoneNumber = phone;
    loading = true;
    notifyListeners();

    final response =
        await http.post(Uri.parse('${AppURL.baseURL}/accounts/onboarding'),
            headers: basicHeader,
            body: jsonEncode(<String, String>{
              'phone': phone,
            }));

    loading = false;
    notifyListeners();

    final body = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      newClient = body['newClient'];
      token = body['token'];

      errorMessage = '';

      notifyListeners();
    }
  }

  verifyCode(String code) async {
    final response = await http.post(
        Uri.parse('${AppURL.baseURL}/accounts/onboarding/verify-code'),
        headers: authHeader(token),
        body: jsonEncode(<String, String>{
          'phone': phoneNumber,
          'code': code,
        }));

    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      token = json['token'];
      setToken(token);
      notifyListeners();

      account = Account.fromJSON(json['account']);
      setAccount(account);

      if (newClient) {
      } else {}

      errorMessage = '';

      notifyListeners();
    } else {
      errorMessage = json['message'];
      notifyListeners();
    }
  }

  addName(String lastName, String firstName) async {
    loading = true;
    notifyListeners();

    final response =
        await http.post(Uri.parse('${AppURL.baseURL}/accounts/onboarding/name'),
            headers: authHeader(token),
            body: jsonEncode(<String, String>{
              "firstName": firstName,
              "lastName": lastName,
            }));

    loading = false;
    notifyListeners();

    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      token = json['token'];
      setToken(token);
      notifyListeners();

      account = Account.fromJSON(json['account']);
      setAccount(account);
    } else {
      errorMessage = json['message'];
    }
  }

  logout() async {
    account = Account();
    token = '';
    notifyListeners();

    removeAccount();
    removeToken();
  }
}
