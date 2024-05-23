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

String homeAddress = 'Strada Dealu cu Piatra 2';
String workAddress = 'Strada Ion Th. Grigore 22';

Map<String, IconData> lineIcons = {
  "BUS": Icons.directions_bus_rounded,
  "TRAM": Icons.tram,
  "TROLLEY": Icons.directions_transit,
  "SUBWAY": Icons.subway_rounded,
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

Map<String, Color> mapPlaceColors = {
  "restaurant": Color(0xFFF44336), // Red
  "cafe": Color(0xFF795548), // Brown
  "bar": Color(0xFF9C27B0), // Purple
  "atm": Color(0xFF4CAF50), // Green
  "bank": Color(0xFF2196F3), // Blue
  "gas_station": Color(0xFFFFC107), // Amber
  "parking": Color(0xFF9E9E9E), // Grey
  "pharmacy": Color(0xFFFF5722), // Deep Orange
  "hospital": Color(0xFFE91E63), // Pink
  "museum": Color(0xFF673AB7), // Deep Purple
  "park": Color(0xFF4CAF50), // Green
  "library": Color(0xFF3F51B5), // Indigo
  "supermarket": Color(0xFFFFEB3B), // Yellow
  "shopping_mall": Color(0xFF673AB7), // Yellow
  "convenience_store": Color(0xFFFF9800), // Orange
  "train_station": Color(0xFF607D8B), // Blue Grey
  "bus_station": Color(0xFF2196F3), // Blue
  "airport": Color(0xFF00BCD4), // Cyan
  "movie_theater": Color(0xFFE91E63), // Pink
  "taxi_stand": Color(0xFFFFC107), // Amber
  "bicycle_store": Color(0xFF4CAF50), // Green
  "post_office": Color(0xFFFF5722), // Deep Orange
  "university": Color(0xFF3F51B5),
  "general": Color(0xFF2196F3),
};
