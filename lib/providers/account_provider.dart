import 'dart:convert';

import 'package:application/models/place.dart';
import 'package:application/utils/types.dart';
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

  int selectedPM = 0;
  String clientSecret = '';
  String paymentIntent = '';
  bool setupConfirmed = true;

  loadAccount() async {
    token = await getToken();
    account = await getAccount();
    notifyListeners();
  }

  setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  setSelectedPM(int index) {
    selectedPM = index;
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

  getTrips() async {
    loading = true;
    notifyListeners();

    final response = await http.get(
        Uri.parse('${AppURL.baseURL}/accounts/trips'),
        headers: authHeader(token));

    loading = false;
    notifyListeners();

    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      List<Place> tempTrips = [];
      for (int i = json.length - 1; i >= 0; i--) {
        tempTrips.add(Place.fromTrip(json[i]));
      }

      account.trips = tempTrips;
      notifyListeners();
    } else {
      errorMessage = json['message'];
    }
  }

  Future<void> addTrip(Place p) async {
    loading = true;
    notifyListeners();

    final response =
        await http.put(Uri.parse('${AppURL.baseURL}/accounts/trips'),
            headers: authHeader(token),
            body: jsonEncode(<String, String>{
              'placeID': p.placeID,
              'mainText': p.mainText,
              'secondaryText': p.secondaryText ?? '',
              'type': processTypes(p.types),
            }));

    loading = false;
    notifyListeners();

    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      List<Place> tempTrips = [];

      for (int i = json.length - 1; i > 0; i--) {
        tempTrips.add(Place.fromTrip(json[i]));
      }

      account.trips = tempTrips;
      notifyListeners();
    } else {
      errorMessage = json['message'];
    }
  }

  getPaymentMethods() async {
    loading = true;
    notifyListeners();

    final response = await http.get(
        Uri.parse('${AppURL.baseURL}/accounts/payments/methods'),
        headers: authHeader(token));

    loading = false;
    notifyListeners();

    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      List<PaymentMethod> pmList = [];
      for (int i = 0; i < json.length; i++) {
        pmList.add(PaymentMethod.fromJSON(json[i]));
      }

      account.paymentMethods = pmList;
      notifyListeners();
    } else {
      errorMessage = json['message'];
    }
  }

  createSetupIntent() async {
    loading = true;
    notifyListeners();

    final response = await http.post(
        Uri.parse('${AppURL.baseURL}/accounts/payments/setup-intent'),
        headers: authHeader(token));

    loading = false;
    notifyListeners();

    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      clientSecret = json['clientSecret'];
      setupConfirmed = false;
      notifyListeners();
    } else {
      errorMessage = json['message'];
      notifyListeners();
    }
  }

  confirmSetupIntent(String pm) async {
    loading = true;
    notifyListeners();

    final response = await http.post(
        Uri.parse('${AppURL.baseURL}/accounts/payments/setup-confirm'),
        headers: authHeader(token),
        body: jsonEncode(<String, String>{
          "paymentMethod": pm,
        }));

    loading = false;
    notifyListeners();

    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      token = json['token'];
      setupConfirmed = true;
      setToken(token);
      notifyListeners();
    } else {
      errorMessage = json['message'];
    }
  }

  createPaymentIntent(int amount) async {
    loading = true;
    notifyListeners();

    final response = await http.post(
        Uri.parse('${AppURL.baseURL}/accounts/payments/payment-intent'),
        headers: authHeader(token),
        body: jsonEncode(<String, int>{
          'amount': amount,
          'paymentMethod': selectedPM,
        }));

    loading = false;
    notifyListeners();

    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      clientSecret = json['clientSecret'];
      paymentIntent = json['paymentIntent'];
      notifyListeners();
    } else {
      errorMessage = json['message'];
      notifyListeners();
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
