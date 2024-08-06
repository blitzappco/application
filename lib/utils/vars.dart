import 'package:flutter/material.dart';

//Colors
const Color crayolaYellow = Color(0xFFF1D7A3);
const Color circleOfTravel = Color(0xFFFF9F40);
const Color travelOrange = Color(0xFFFF8811);
const Color tealishSea = Color(0xFF275671);
const Color iosGrey = Color(0xFFB2B2B2);
const Color lightGrey = Color(0xFFE8E8E8);
const Color darkGrey = Color(0XFF6E6E6E);
// const Color blitzPurple = Color(0xFF5100CC);
const Color blitzPurple = Color(0xFF3834FC);
const Color accentBlue = Colors.blue;
const Color accentPurple = Color(0xFF6C69FF);

//Variables

String homeAddress = 'Strada Dealu cu Piatra 2';
String workAddress = 'Strada Ion Th. Grigore 22';

Map<String, IconData> lineIcons = {
  "BUS": Icons.directions_bus_rounded,
  "TRAM": Icons.tram,
  "TROLLEY": Icons.directions_transit,
  "SUBWAY": Icons.subway_rounded,
};

Map<String, IconData> placeIcons = {
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
  "supermarket": Icons.shopping_cart_rounded,
  "convenience_store": Icons.local_convenience_store_rounded,
  "shopping_mall": Icons.shopping_bag_rounded,
  "train_station": Icons.directions_railway_rounded,
  "bus_station": Icons.directions_bus_rounded,
  "airport": Icons.flight_rounded,
  "movie_theater": Icons.local_movies_rounded,
  "taxi_stand": Icons.local_taxi_rounded,
  "bicycle_store": Icons.directions_bike_rounded,
  "post_office": Icons.local_post_office_rounded,
  "university": Icons.school_rounded,
  "general": Icons.location_city_rounded,
};

Map<String, Color> placeColors = {
  "restaurant": const Color(0xFFF44336), // Red
  "cafe": const Color(0xFF795548), // Brown
  "bar": const Color(0xFF9C27B0), // Purple
  "atm": const Color(0xFF4CAF50), // Green
  "bank": const Color(0xFF2196F3), // Blue
  "gas_station": const Color(0xFFFFC107), // Amber
  "parking": const Color(0xFF9E9E9E), // Grey
  "pharmacy": const Color(0xFFFF5722), // Deep Orange
  "hospital": const Color(0xFFE91E63), // Pink
  "museum": const Color(0xFF673AB7), // Deep Purple
  "park": const Color(0xFF4CAF50), // Green
  "library": const Color(0xFF3F51B5), // Indigo
  "supermarket": const Color(0xFFFFEB3B), // Yellow
  "shopping_mall": const Color(0xFF673AB7), // Yellow
  "convenience_store": const Color(0xFFFF9800), // Orange
  "train_station": const Color(0xFF607D8B), // Blue Grey
  "bus_station": const Color(0xFF2196F3), // Blue
  "airport": const Color(0xFF00BCD4), // Cyan
  "movie_theater": const Color(0xFFE91E63), // Pink
  "taxi_stand": const Color(0xFFFFC107), // Amber
  "bicycle_store": const Color(0xFF4CAF50), // Green
  "post_office": const Color(0xFFFF5722), // Deep Orange
  "university": const Color(0xFF3F51B5),
  "general": const Color(0xFF2196F3),
};

//Developer Mode

bool DEV = true;
