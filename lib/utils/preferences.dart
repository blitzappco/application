import 'package:shared_preferences/shared_preferences.dart';
import 'package:blitz/bifrost/mantle/models/account.dart';

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}

Future<Account> getAccount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return Account(
    id: prefs.getString('account.id'),
    phone: prefs.getString('account.phone'),
    firstName: prefs.getString('account.firstName'),
    lastName: prefs.getString('account.lastName'),
    stripeCustomerID: prefs.getString('account.stripeCustomerID'),
  );
}

void setToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

void setAccount(Account account) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('account.id', account.id.toString());
  await prefs.setString('account.phone', account.phone.toString());
  await prefs.setString('account.firstName', account.firstName.toString());
  await prefs.setString('account.lastName', account.lastName.toString());
  await prefs.setString(
      'account.stripeCustomerID', account.stripeCustomerID.toString());
}

void removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}

void removeAccount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('account.id');
  await prefs.remove('account.phone');
  await prefs.remove('account.firstName');
  await prefs.remove('account.lastName');
  await prefs.remove('account.stripeCustomerID');
}

void removePrefs() async {
  removeToken();
  removeAccount();
}
