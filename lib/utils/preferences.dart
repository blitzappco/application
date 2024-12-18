import 'dart:convert';

import 'package:blitz/utils/stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blitz/bifrost/mantle/models/account.dart';

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}

Future<int> getSelectedPM() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('selectedPM') ?? 0;
}

Future<Account> getAccount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final accountString = prefs.getString("account") ?? '';
  var account = Account.fromEmpty();

  if (accountString != '') {
    account = Account.fromJSON(jsonDecode(accountString));

    account.paymentMethods =
        await addPlatformPaymentMethod(account.paymentMethods!);
  }

  return account;
}

void setToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

void changeSelectedPM(int selectedPM) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('selectedPM', selectedPM);
}

void setAccount(Account account) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString("account", jsonEncode(account.toJSON()));
}

void removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}

void removeSelectedPM() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('selectedPM');
}

void removeAccount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove("account");
}

void removePrefs() async {
  removeToken();
  removeAccount();
}
