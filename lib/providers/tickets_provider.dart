import 'dart:convert';

import 'package:flutter/material.dart';
import '../utils/url.dart';
import 'package:http/http.dart' as http;

import '../models/ticket.dart';

class TicketsProvider with ChangeNotifier {
  List<Ticket> list = [];

  late Ticket last;
  late bool show;

  bool loading = false;
  String errorMessage = '';

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

  getLastTicket(String token) async {
    loading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('${AppURL.baseURL}/tickets/last'),
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
}
