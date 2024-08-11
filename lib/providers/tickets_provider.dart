import 'dart:developer';

import 'package:blitz/bifrost/mercury/models/ticket_type.dart';
import 'package:blitz/bifrost/mercury/models/ticket.dart';
import 'package:blitz/bifrost/mercury/purchase.dart';
import 'package:blitz/bifrost/mercury/tickets.dart';
import 'package:blitz/utils/process_ticket_types.dart';
import 'package:flutter/material.dart';

class TicketsProvider with ChangeNotifier {
  List<Ticket> list = [];
  Map<String, List<TicketType>> typesMap = {};
  Map<String, TicketType> ticketTypesMap = {};

  Ticket purchased = Ticket(confirmed: false);

  late Ticket last;
  late bool show = false;
  String expiry = '';

  bool loading = false;
  String errorMessage = '';
  bool buyLoading = false;
  bool mustActivate = false;

  int fare = 0;
  String ticketID = '';
  bool confirmed = true;
  String clientSecret = '';
  String paymentIntent = '';

  setBuyLoading(bool value) {
    buyLoading = value;
    notifyListeners();
  }

  setMustActivate(bool value) {
    mustActivate = value;
    notifyListeners();
  }

  setConfirmed(bool value) {
    confirmed = value;
    notifyListeners();
  }

  setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  setTicketID(String value) {
    ticketID = value;
    notifyListeners();
  }

  setExpiry(String value) {
    expiry = value;
    notifyListeners();
  }

  Future<void> validateTicket(String token, String ticketID) async {
    loading = true;
    notifyListeners();

    final body = await postValidateTicket(token, ticketID);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      last = Ticket.fromJSON(body["ticket"]);
      notifyListeners();
    } else {
      setError(body["message"]);
    }
  }

  // get ticket types per city
  getTicketTypes(String token, String city) async {
    loading = true;
    notifyListeners();

    final body = await fetchTicketTypes(token, city);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      List<TicketType> ticketTypesList = List<TicketType>.from(
          body["ticketTypes"].map((x) => TicketType.fromJSON(x)));

      typesMap = processTicketTypes(ticketTypesList);
      ticketTypesMap = typesToMap(ticketTypesList);
      notifyListeners();
    } else {
      setError('Nu s-au putut gasi tipurile de bilete');
    }
  }

  // gets all tickets on account
  getTickets(String token) async {
    loading = true;
    notifyListeners();

    final body = await fetchTickets(token);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      List<Ticket> ticketsList =
          List<Ticket>.from(body["tickets"].map((x) => Ticket.fromJSON(x)));

      list = ticketsList.reversed.toList();
      notifyListeners();
    } else {
      setError('Nu s-au putut gasi biletele existente');
    }
  }

  // get last ticket per city
  getLastTicket(String token, String city) async {
    loading = true;
    notifyListeners();

    final body = await fetchLastTicket(token, city);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      show = body['show'];
      last = Ticket.fromJSON(body['ticket']);

      notifyListeners();
    } else {
      setError('Nu s-au putut gasi biletele existente');
    }
  }

  createPurchase(String token, String typeID, String name) async {
    loading = true;
    notifyListeners();

    final body = await postPurchase(token, typeID, name);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      ticketID = body['ticketID'];
      fare = body['fare'];

      notifyListeners();
    } else {
      setError(body["message"]);
    }
  }

  createPayment(String token, int paymentMethod) async {
    loading = true;
    notifyListeners();

    final body = await postPurchasePayment(token, paymentMethod, fare);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      clientSecret = body['clientSecret'];
      paymentIntent = body['paymentIntent'];

      notifyListeners();
    } else {
      setError(body['message']);
    }
  }

  Future<void> attachPurchasePayment(String token) async {
    loading = true;
    notifyListeners();

    final body = await postPurchaseAttach(token, paymentIntent, ticketID);
    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      inspect(body["ticket"]);
      purchased = Ticket.fromJSON(body["ticket"]);
      inspect(purchased);

      notifyListeners();
    } else {
      setError(body["message"]);
    }
  }

  movePurchasedToLast() {
    last = purchased;
    last.confirmed = true;
    show = true;
    list.add(last);

    purchased = Ticket();
    ticketID = '';
    fare = 0;
    confirmed = true;

    notifyListeners();
  }

  confirmPurchase(String token) async {
    loading = true;
    notifyListeners();

    final body = await fetchTicket(token, ticketID);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
      final tempTicket = Ticket.fromJSON(body["ticket"]);
      if (tempTicket.confirmed == true) {
        disposePurchase();
        last = tempTicket;
        show = true;
        list.add(tempTicket);
      }
      notifyListeners();
    } else {
      setError(body['message']);
    }
  }

  cancelPurchase(String token) async {
    loading = true;
    notifyListeners();

    final body = await deletePurchase(token, ticketID);

    loading = false;
    notifyListeners();

    if (body["statusCode"] == 200) {
    } else {
      setError(body['message']);
    }
  }

  disposePurchase() {
    purchased = Ticket();
    ticketID = '';
    fare = 0;
    show = false;
    confirmed = true;
    notifyListeners();
  }
}
