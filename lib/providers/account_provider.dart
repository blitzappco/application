import 'dart:convert';

import 'package:blitz/bifrost/core/models/place.dart';
import 'package:blitz/bifrost/mantle/onboarding.dart';
import 'package:blitz/bifrost/mantle/payment_methods.dart';
import 'package:blitz/bifrost/mantle/trips.dart';
import 'package:blitz/bifrost/mantle/labels.dart';
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

  // for labels
  Place labelPlace = Place.fromEmpty();

  loadAccount() async {
    token = await getToken();
    account = await getAccount();
    selectedPM = await getSelectedPM();
    notifyListeners();
  }

  setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  setSelectedPM(int index) {
    selectedPM = index;
    changeSelectedPM(index);
    notifyListeners();
  }

  Future<void> onboarding(String phone) async {
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

  Future<void> verifyCode(String code) async {
    loading = true;
    notifyListeners();

    final body = await postOnboardingCode(token, code, newClient);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      token = body['token'];
      setToken(token);

      account = Account.fromJSON(body['account']);
      account.trips = account.trips?.reversed.toList();
      setAccount(account);

      setSelectedPM(0);

      await setError('');

      notifyListeners();
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

    final body = await fetchTrips(token);

    loading = false;
    notifyListeners();

    if (body['statusCode'] == 200) {
      account.trips = [];
      for (int i = 0; i < body['trips'].length; i++) {
        account.trips?.add(Place.fromTrip(body['trips'][i]));
      }
      account.trips = account.trips?.reversed.toList();

      setAccount(account);

      notifyListeners();
    } else {
      setError(body["message"]);
    }
  }

  Future<void> addTrip(Place p) async {
    loading = true;
    notifyListeners();

    final body = await postTrip(token, p);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      account.trips = [];
      for (int i = 0; i < body['trips'].length; i++) {
        account.trips?.add(Place.fromTrip(body['trips'][i]));
      }

      token = body["token"];
      setToken(token);
      setAccount(account);

      account.trips = account.trips?.reversed.toList();
      notifyListeners();
    } else {
      setError(body["message"]);
    }
  }

  getLabels() async {
    loading = true;
    notifyListeners();

    final body = await fetchLabels(token);

    loading = false;
    notifyListeners();

    if (body['statusCode'] == 200) {
      account.labels = [];
      for (int i = 0; i < body['labels'].length; i++) {
        account.labels?.add(Label.fromJSON(body['labels'][i]));
      }

      setAccount(account);

      notifyListeners();
    } else {
      setError(body["message"]);
    }
  }

  addLabel(Label l) async {
    loading = true;
    notifyListeners();

    final body = await postLabel(token, l);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      account.labels = [];
      for (int i = 0; i < body['labels'].length; i++) {
        account.labels?.add(Label.fromJSON(body['labels'][i]));
      }

      token = body["token"];
      setToken(token);
      setAccount(account);

      notifyListeners();
    } else {
      setError(body["message"]);
    }
  }

  changeLabel(int index, Label l) async {
    loading = true;
    notifyListeners();

    final body = await patchLabel(token, index, l);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      account.labels = [];
      for (int i = 0; i < body['labels'].length; i++) {
        account.labels?.add(Label.fromJSON(body['labels'][i]));
      }

      token = body["token"];
      setToken(token);
      setAccount(account);

      notifyListeners();
    } else {
      setError(body["message"]);
    }
  }

  setLabelPlace(Place p) async {
    labelPlace = p;
    notifyListeners();
  }

  Future<void> clearLabelPlace() async {
    labelPlace.placeID = '';
    notifyListeners();
  }

  Future<void> removeLabel(int index) async {
    loading = true;
    notifyListeners();

    final body = await deleteLabel(token, index);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      account.labels = [];
      for (int i = 0; i < body['labels'].length; i++) {
        account.labels?.add(Label.fromJSON(body['labels'][i]));
      }

      token = body["token"];
      setToken(token);
      setAccount(account);

      notifyListeners();
    } else {
      setError(body["message"]);
    }
  }

  getPaymentMethods() async {
    loading = true;
    notifyListeners();

    final body = await fetchPaymentMethods(token);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      List<PaymentMethod> pmList = [];
      for (int i = 0; i < body["paymentMethods"].length; i++) {
        pmList.add(PaymentMethod.fromJSON(body["paymentMethods"][i]));
      }

      account.paymentMethods = pmList;
      notifyListeners();
    } else {
      setError(body['message']);
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

  logout() async {
    account = Account();
    token = '';
    selectedPM = 0;
    notifyListeners();

    removeAccount();
    removeToken();
    removeSelectedPM();
  }
}
