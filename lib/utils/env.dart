import 'package:flutter/material.dart';

//Colors
const Color crayolaYellow = Color(0xFFF1D7A3);
const Color circleOfTravel = Color(0xFFFF9F40);
const Color travelOrange = Color(0xFFFF8811);
const Color tealishSea = Color(0xFF275671);
const Color iosGrey = Color(0xFFB2B2B2);
const Color lightGrey = Color(0xFFE8E8E8);
const Color darkGrey = Color(0XFF6E6E6E);
const Color blitzPurple = Color(0xFF5100CC);
const Color accentBlue = Colors.blue;

//Variables
String mapKey = 'AIzaSyDx3BqjwYrrouBSBixr8j3xrXVRKPjg44g';

String homeAddress = 'Strada Dealu cu Piatra 2';
String workAddress = 'Strada Ion Th. Grigore 22';

// the colors for the line widgets
Map<String, Color> lineColors = {
  //Tram STPT
  "1": const Color(0xFF2F046F),
  "2": const Color.fromARGB(255, 221, 3, 24),
  "6": const Color.fromARGB(255, 255, 245, 141),
  "7": const Color.fromARGB(255, 255, 69, 190),
  "8": const Color.fromARGB(255, 53, 53, 53),
  "9": const Color.fromARGB(255, 128, 242, 255),
  //Bus STPT
  "5": const Color.fromARGB(255, 134, 255, 231),
  "13": const Color.fromARGB(255, 145, 174, 218),
  "21": const Color.fromARGB(255, 141, 220, 89),
  "28": const Color.fromARGB(255, 255, 178, 69),
  "32": const Color.fromARGB(255, 115, 44, 169),
  "33": const Color.fromARGB(255, 253, 86, 86),
  "33B": const Color.fromARGB(255, 0, 191, 255),
  "40": const Color.fromARGB(255, 42, 42, 42),
  "46": const Color.fromARGB(255, 232, 185, 185),
  //Express lines STPT
  "E1": const Color.fromARGB(255, 12, 140, 16),
  "E2": const Color.fromARGB(255, 217, 35, 160),
  "E3": const Color.fromARGB(255, 62, 141, 220),
  "E4": const Color.fromARGB(255, 110, 110, 110),
  "E4B": const Color.fromARGB(255, 105, 255, 152),
  "E6": const Color.fromARGB(255, 252, 55, 55),
  "E7": const Color.fromARGB(255, 255, 174, 69),
  "E8": const Color.fromARGB(255, 53, 53, 53),
  //Trolley STPT
  "11": const Color.fromARGB(255, 20, 185, 255),
  // "13": Color.fromRGBO(255, 41, 41, 1),
  "14": const Color.fromARGB(255, 255, 255, 20),
  "15": const Color.fromARGB(255, 145, 228, 77),
  "16": const Color.fromARGB(255, 96, 96, 96),
  "17": const Color.fromARGB(255, 77, 47, 122),
  "18": const Color.fromARGB(255, 209, 139, 47),
  //Metro Trolleys STPT
  "M11": const Color.fromARGB(255, 49, 59, 130),
  "M14": const Color.fromARGB(255, 135, 104, 151),
  //Metro  Bus lines STPT
  "M22": const Color.fromARGB(255, 51, 128, 77),
  "M27": const Color.fromARGB(255, 71, 212, 99),
  "M29": const Color.fromARGB(255, 17, 2, 47),
  "M30": const Color.fromARGB(255, 122, 209, 255),
  "M35": const Color.fromARGB(255, 255, 226, 200),
  "M36": const Color.fromARGB(255, 255, 240, 32),
  "21": const Color.fromARGB(255, 136, 0, 255),
  "M41": const Color.fromARGB(255, 255, 136, 68),
  "M42": const Color.fromARGB(255, 20, 132, 176),
  "M43": const Color.fromARGB(255, 255, 72, 72),
  "M44": const Color.fromARGB(255, 216, 127, 246),
  "M45": const Color.fromARGB(255, 124, 124, 124),
  "M46": const Color.fromARGB(255, 103, 226, 202),
  "M47": const Color.fromARGB(255, 46, 190, 234),
  "M48": const Color.fromARGB(255, 251, 195, 99),
  "M49": const Color.fromARGB(255, 0, 111, 30),
  "M50": const Color.fromARGB(255, 111, 50, 186),
  "M51": const Color.fromARGB(255, 254, 178, 255),
  "M52": const Color.fromARGB(255, 97, 101, 235),

  //Ploiesti
  // "44": const Color(0xFFbcdc84),
  // "202": const Color(0xFFdb2220),
  // "1": const Color(0xFFdf78cb),
  // "2": const Color(0xFFaad5a1),
  // "4": const Color(0xFF4b82ef),
  // "4B": const Color(0xFF1800b1),
  // "5": const Color(0xFFeb9077),
  // "7": const Color(0xFFbfbd67),
  // "8": const Color(0xFF1600c1),
  // "22": const Color(0xFF892e1f),
  // "25R": const Color(0xFFa12bab),
  // "28": const Color(0xFFff00a8),
  // "30": const Color(0xFF0793d8),
  // "32": const Color(0xFF93cce1),
  // "35": const Color(0xFFefa442),
  // "21": const Color(0xFFefa442),
  // "36": const Color(0xFFff00a8),
  // "39B": const Color(0xFF627d7f),
  // "40": const Color(0xFFeec08e),
  // "40B": const Color(0xFFeec08e),
  // "42": const Color(0xFFa12bab),
  // "44B": const Color(0xFFff00a8),
  // "48": const Color(0xFFa12bab),
  // "52": const Color(0xFFff00a8),
  // "53": const Color(0xFFa12bab),
  // "54": const Color(0xFFa12bab),
  // "104": const Color(0xFF0a903c),
  // "106": const Color(0xFFff00a8),
  // "300": const Color(0xFF6e33ec),
  // "301": const Color(0xFF6e33ec),
  // "302": const Color(0xFF6e33ec),
  // "303": const Color(0xFF6e33ec),
  // "304": const Color(0xFF6e33ec),
  // "305": const Color(0xFF6e33ec),
  // "306": const Color(0xFF6e33ec),
  // "307": const Color(0xFF6e33ec),
  // "401": const Color(0xFFa700c8),
  // "402": const Color(0xFFff007f),
  // "444": const Color(0xFFffee00),
  // "445": const Color(0xFFff5420),
};

Map<String, IconData> lineIcons = {
  "BUS": Icons.directions_bus_rounded,
  "TRAM": Icons.tram,
  "TROLLEYBUS": Icons.directions_transit,
};

Map<String, IconData> mapPlaceIcons = {
  "restaurant": Icons.restaurant_rounded,
  "cafe": Icons.local_cafe_rounded,
  "bar": Icons.local_bar_rounded,
  "atm": Icons.atm_rounded,
  "bank": Icons.money_rounded,
  "gas_station": Icons.local_gas_station_rounded,
  "parking": Icons.local_parking_rounded,
  "pharmacy": Icons.local_pharmacy_rounded,
  "hospital": Icons.local_hospital_rounded,
  "museum": Icons.museum_rounded,
  "park": Icons.park_rounded,
  "library": Icons.local_library_rounded,
  "grocery_or_supermarket": Icons.shopping_cart_rounded,
  "convenience_store": Icons.local_convenience_store_rounded,
  "train_station": Icons.directions_railway_rounded,
  "bus_station": Icons.directions_bus_rounded,
  "airport": Icons.flight_rounded,
  "movie_theater": Icons.local_movies_rounded,
  "taxi_stand": Icons.local_taxi_rounded,
  "bicycle_rental": Icons.directions_bike_rounded,
  "tourist_information_center": Icons.info_outline_rounded,
  "post_office": Icons.local_post_office_rounded,
};
