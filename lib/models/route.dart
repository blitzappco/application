import 'dart:ffi';

class Bounds {
  Double northEastLat;
  Double northEastLng;
  Double southWestLat;
  Double southWestLng;

  Bounds({
    required this.northEastLat,
    required this.northEastLng,
    required this.southWestLat,
    required this.southWestLng,
  });

  factory Bounds.fromJSON(Map<String, dynamic> json) {
    return Bounds(
      northEastLat: json['northeast']['lat'],
      northEastLng: json['northeast']['lng'],
      southWestLat: json['southwest']['lat'],
      southWestLng: json['southwest']['lng'],
    );
  }
}

class Route {}
