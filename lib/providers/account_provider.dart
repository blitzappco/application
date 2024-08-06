import 'dart:convert';

import 'package:blitz/bifrost/core/models/place.dart';
import 'package:blitz/bifrost/mantle/endpoints.dart';
import 'package:blitz/utils/types.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:blitz/bifrost/mantle/models/account.dart';
import '../utils/url.dart';
import '../utils/preferences.dart';

class AccountProvider with ChangeNotifier {
  // used for onboarding
  String phoneNumber = '';
  String token = '';
  bool newClient = false;

  // geneeral signals
  bool loading = false;
  String errorMessage = '';

  // actual account instance
  Account account = Account();

  // used for payment
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

    final body = await postOnboarding(phone);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      newClient = body['newClient'];
      token = body['token'];

      await setError('');
    } else {
      await setError(body["message"]);
    }
  }

  verifyCode(String code) async {
    loading = true;
    notifyListeners();

    final body = await postOnboardingCode(token, code, newClient);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      token = body['token'];
      setToken(token);
      notifyListeners();

      account = Account.fromJSON(body['account']);
      setAccount(account);

      await setError('');
    } else {
      await setError(body["message"]);
    }
  }

  addName(String lastName, String firstName) async {
    loading = true;
    notifyListeners();

    final body = await postOnboardingName(token, firstName, lastName);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      token = body['token'];
      setToken(token);
      notifyListeners();

      account = Account.fromJSON(body['account']);
      setAccount(account);

      setError('');
    } else {
      setError(body['message']);
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
