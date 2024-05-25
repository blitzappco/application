import 'package:blitz/models/ticket.dart';
import 'package:blitz/models/tickety_type.dart';

Map<String, String> expiries = {
  '1.5h': "90 minutes",
  '2h': "120 minutes",
  '1d': "1 day",
  '3d': "2 days",
  '1w': "a week",
};

Map<int, String> trips = {
  1: '1 trip',
  2: '2 trips',
  10: '10 trips',
};

Map<String, String> modes = {"s": '', "s+m": "including subway"};

Map<String, List<TicketType>> processTicketTypes(List<TicketType> typesList) {
  Map<String, List<TicketType>> result = {
    "Pass": [],
    "Ticket": [],
  };

  for (int i = 0; i < typesList.length; i++) {
    if (typesList[i].trips == -1) {
      result["Pass"]?.add(typesList[i]);
    } else {
      result["Ticket"]?.add(typesList[i]);
    }
  }

  return result;
}

String processTypeTitle(TicketType type) {
  String result = '';

  bool pass = type.trips == -1;

  if (pass) {
    result += "Pass for ";
    result += expiries[type.expiry] ?? '';
    result += ' ${modes[type.mode] ?? ''}';
  } else {
    result += "Ticket for ";
    result += trips[type.trips] ?? '';
    result += ' ${modes[type.mode] ?? ''}';
  }

  return result;
}

String processTicketTitle(Ticket ticket) {
  String result = '';

  bool pass = ticket.trips == -1;

  if (pass) {
    result += "Pass for ";
    result += expiries[ticket.expiry] ?? '';
    result += ' ${modes[ticket.mode] ?? ''}';
  } else {
    result += "Ticket for ";
    result += trips[ticket.trips] ?? '';
    result += ' ${modes[ticket.mode] ?? ''}';
  }

  return result;
}
