import 'package:intl/intl.dart';

String normalizeInstructions(String instructions) {
  return instructions;
}

String normalizeDuration(int value) {
  String result = '';

  int minutes = 0;
  int hours = 0;

  if (value >= 60 * 60) {
    // greater than an hour
    while (value > 60 * 60) {
      value -= 60 * 60;
      hours += 1;
    }
  }

  if (value > 60) {
    minutes = (value / 60).round();
  }

  if (hours != 0) {
    result += '${hours}h';
  }

  if (hours != 0 && minutes != 0) {
    result += ' ';
  }

  if (minutes != 0) {
    result += '$minutes min';
  }

  return result;
}

String normalizeTime(String raw) {
  List<String> tokens = raw.split(':');

  String hour = tokens[0];
  String minutes = tokens[1].substring(0, 2);
  String meridian = tokens[1].substring(3);

  if (meridian == "AM") {
    if (hour == '12') {
      return '0:$minutes';
    } else {
      return '$hour:$minutes';
    }
  } else {
    if (hour == '12') {
      return tokens[0];
    } else {
      return '${int.parse(hour) + 12}:$minutes';
    }
  }
}

String normalizeDistance(int value) {
  String result = '';

  if (value > 1000) {
    double km = value / 1000;
    result += '${km.toStringAsFixed(1)} km';
  } else {
    result += '$value m';
  }

  return result;
}

String formatDate(DateTime ticketDate) {
  DateTime now = DateTime.now().toLocal();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = today.subtract(const Duration(days: 1));

  if (ticketDate.isAfter(today)) {
    // Ticket bought today, show HH:MM
    return 'Today, ${DateFormat.Hm().format(ticketDate)}';
  } else if (ticketDate.isAfter(yesterday)) {
    // Ticket bought yesterday, show yesterday
    return 'Yesterday, ${DateFormat.Hm().format(ticketDate)}';
  } else {
    // Ticket bought earlier than yesterday, show DD MMM YY
    return DateFormat('dd MMMM').format(ticketDate);
  }
}

String getRomanianPlurals(int value, String singular, String plural) {
  String ret = "$value ";
  if (value == 1) {
    ret += singular;
  } else if (value >= 20) {
    ret += 'de $plural';
  } else {
    ret += plural;
  }
  return ret;
}

// String calculateRomanianExpiry(DateTime expiryDate, DateTime now) {
//   // final now = DateTime.now();
//   final difference = expiryDate.difference(now);

//   int rawDays = difference.inDays;
//   int rawHours = difference.inHours - difference.inDays * 24;
//   int rawMinutes = difference.inMinutes - difference.inHours * 60;
//   int rawSeconds = difference.inSeconds - difference.inMinutes * 60;

//   String ret = '';

//   if (difference.isNegative) {
//     return 'exp';
//   }

//   // ret += 'Valabil ';
//   String days = getRomanianPlurals(rawDays, "zi", "zile");
//   String hours = getRomanianPlurals(rawHours, "ora", "ore");
//   String minutes = getRomanianPlurals(rawMinutes, "minut", "minute");
//   String seconds = getRomanianPlurals(rawSeconds, "secunda", "secunde");

//   if (difference.inDays >= 1) {
//     ret += '$days si';
//     if (difference.inHours >= 1) ret += ' $hours';
//   } else if (difference.inHours >= 1) {
//     ret += '$hours si';
//     if (difference.inMinutes >= 1) ret += ' $minutes';
//   } else if (difference.inMinutes >= 1) {
//     ret += '$minutes si';
//     if (difference.inSeconds >= 1) ret += ' $seconds';
//   } else {
//     ret += seconds;
//   }

//   return ret;
// }

String calculateExpiry(DateTime expiryDate, DateTime now) {
  // final now = DateTime.now();
  final difference = expiryDate.difference(now);

  int rawDays = difference.inDays;
  int rawHours = difference.inHours - difference.inDays * 24;
  int rawMinutes = difference.inMinutes - difference.inHours * 60;
  int rawSeconds = difference.inSeconds - difference.inMinutes * 60;

  String ret = '';

  if (difference.isNegative) {
    return 'exp';
  }

  // ret += 'Valabil ';
  String days = '${rawDays}d';
  String hours = '${rawHours}h';
  String minutes = '${rawMinutes}m';
  String seconds = '${rawSeconds}s';

  if (difference.inDays >= 1) {
    ret += days;
    if (difference.inHours >= 1) ret += ' $hours';
  } else if (difference.inHours >= 1) {
    ret += hours;
    if (difference.inMinutes >= 1) ret += ' $minutes';
  } else if (difference.inMinutes >= 1) {
    ret += minutes;
    if (difference.inSeconds >= 1) ret += ' $seconds';
  } else {
    ret += seconds;
  }

  return ret;
}
