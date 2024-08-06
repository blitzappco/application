import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:blitz/bifrost/mantle/models/account.dart';

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}

Future<Account> getAccount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final accountString = prefs.getString("account") ?? '';
  print("ACCOUNTPREF: $accountString");

  if (accountString == '') {
    return Account.fromEmpty();
  } else {
    return Account.fromJSON(jsonDecode(accountString));
  }
}

void setToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

void setAccount(Account account) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString("account", jsonEncode(account.toJSON()));
}

void removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}

void removeAccount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove("account");
}

void removePrefs() async {
  removeToken();
  removeAccount();
}
