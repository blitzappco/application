import 'dart:convert';

import 'package:application/models/tickety_type.dart';
import 'package:application/utils/process_ticket_types.dart';
import 'package:flutter/material.dart';
import '../utils/url.dart';
import 'package:http/http.dart' as http;

import '../models/ticket.dart';

class TicketsProvider with ChangeNotifier {
  List<Ticket> list = [];
  Map<String, List<TicketType>> typesMap = {};

  Ticket purchased = Ticket();

  late Ticket last;
  late bool show = false;

  bool loading = false;
  String errorMessage = '';

  int fare = 0;
  String ticketID = '';
  bool confirmed = true;

  setConfirmed(bool value) {
    confirmed = value;
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
      List<TicketType> ticketTypesList =
          List<TicketType>.from(json.map((x) => TicketType.fromJSON(x)));

      typesMap = processTicketTypes(ticketTypesList);
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
      last = Ticket.fromJSON(json['ticket']);

      notifyListeners();
    } else {
      errorMessage = 'Nu s-au putut gasi biletele existente';
      notifyListeners();
    }
  }

  createPurchaseIntent(String token, String typeID, String name) async {
    loading = true;
    notifyListeners();

    final response = await http.post(
        Uri.parse('${AppURL.baseURL}/tickets/purchase-intent'
            '?typeID=$typeID'),
        headers: authHeader(token),
        body: jsonEncode(<String, String>{
          "name": name,
        }));

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

    final response =
        await http.post(Uri.parse('${AppURL.baseURL}/tickets/purchase-attach'),
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
      Uri.parse('${AppURL.baseURL}/tickets/ticket'
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
        fare = 0;
        last = tempTicket;
        list.add(tempTicket);
        show = true;
        confirmed = true;
      }
      notifyListeners();
    } else {
      errorMessage = json['message'];
      notifyListeners();
    }
  }

  cancelPurchase() {
    purchased = Ticket();
    ticketID = '';
    fare = 0;
    show = true;
    confirmed = true;
    notifyListeners();
  }
}
