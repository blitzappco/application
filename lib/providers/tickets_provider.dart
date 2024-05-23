import 'dart:convert';

import 'package:flutter/material.dart';
import '../utils/url.dart';
import 'package:http/http.dart' as http;

import '../models/ticket.dart';

class TicketsProvider with ChangeNotifier {
  List<Ticket> list = [];

  Ticket purchased = Ticket();

  late Ticket last;
  late bool show;

  bool loading = false;
  String errorMessage = '';

  double fare = 0.0;
  String ticketID = '';
  bool confirmed = true;

  bool disabled = true;

  setDisabled(bool value) {
    disabled = value;
    notifyListeners();
  }

  // get ticket types per city
  getTicketTypes(String token, String city) async {
    loading = true;
    notifyListeners();

    final response = await http.get(
        Uri.parse('${AppURL.baseURL}/tickets/types?city=$city'),
        headers: authHeader(token));

    loading = false;
    notifyListeners();

    dynamic json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<Ticket> ticketsList =
          List<Ticket>.from(json.map((x) => Ticket.fromJSON(x)));

      ticketsList.sort(
          (b, a) => a.expiresAt.toString().compareTo(b.expiresAt.toString()));

      list = ticketsList;
      notifyListeners();
    } else {
      errorMessage = 'Nu s-au putut gasi tipurile de bilete';
      notifyListeners();
    }
  }

  // gets all tickets on account
  getTickets(String token) async {
    loading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('${AppURL.baseURL}/tickets'),
        headers: authHeader(token));

    loading = false;
    notifyListeners();

    dynamic json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<Ticket> ticketsList =
          List<Ticket>.from(json.map((x) => Ticket.fromJSON(x)));

      ticketsList.sort(
          (b, a) => a.expiresAt.toString().compareTo(b.expiresAt.toString()));

      list = ticketsList;
      notifyListeners();
    } else {
      errorMessage = 'Nu s-au putut gasi biletele existente';
      notifyListeners();
    }
  }

  // get last ticket per city
  getLastTicket(String token, String city) async {
    loading = true;
    notifyListeners();

    final response = await http.get(
        Uri.parse('${AppURL.baseURL}/tickets/last?city=$city'),
        headers: authHeader(token));

    loading = false;
    notifyListeners();

    dynamic json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      show = json['show'];
      last = json['ticket'];

      notifyListeners();
    } else {
      errorMessage = 'Nu s-au putut gasi biletele existente';
      notifyListeners();
    }
  }

  createPurchaseIntent(String token, String typeID) async {
    loading = true;
    notifyListeners();

    final response = await http.post(
        Uri.parse('${AppURL.baseURL}/accounts/tickets/purchase-intent'
            '?typeID=$typeID'),
        headers: authHeader(token));

    loading = false;
    notifyListeners();

    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      ticketID = json['ticketID'];
      fare = json['fare'];
      notifyListeners();
    } else {
      errorMessage = json['message'];
      notifyListeners();
    }
  }

  attachPurchasePayment(String token, String paymentIntent) async {
    loading = true;
    notifyListeners();

    final response = await http.post(
        Uri.parse('${AppURL.baseURL}/accounts/tickets/purchase-intent'),
        headers: authHeader(token),
        body: jsonEncode(<String, String>{
          "paymentIntent": paymentIntent,
          "ticketID": ticketID,
        }));
    loading = false;
    notifyListeners();

    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      purchased = Ticket.fromJSON(json);
      confirmed = false;
      notifyListeners();
    } else {
      errorMessage = json['message'];
      notifyListeners();
    }
  }

  confirmPurchase(String token) async {
    loading = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse('${AppURL.baseURL}/accounts/tickets/ticket'
          '?ticketID=$ticketID'),
      headers: authHeader(token),
    );

    loading = false;
    notifyListeners();

    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      final tempTicket = Ticket.fromJSON(json);
      if (tempTicket.confirmed == true) {
        purchased = Ticket();
        ticketID = '';
        fare = 0.0;
        last = tempTicket;
        list.add(tempTicket);
        confirmed = true;
      }
      notifyListeners();
    } else {
      errorMessage = json['message'];
      notifyListeners();
    }
  }
}
