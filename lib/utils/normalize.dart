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
    result += '$minutes';
    if (minutes == 1) {
      result += ' min';
    } else {
      result += ' mins';
    }
  }

  return result;
}

String normalizeTime(String raw) {
  List<String> tokens = raw.split(':');

  String hour = tokens[0];
  String minutes = tokens[1].substring(0, 2);
  String meridian = tokens[1].substring(2);

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
    result += '${km.toStringAsFixed(1)}km';
  } else {
    result += '${value}m';
  }

  return result;
}
