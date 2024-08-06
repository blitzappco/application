import 'package:blitz/bifrost/core/models/route.dart' as route;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng convertPoint(PointLatLng p) {
  return LatLng(p.latitude, p.longitude);
}

List<LatLng> convertPoints(String polyline) {
  List<PointLatLng> list = PolylinePoints().decodePolyline(polyline);
  List<LatLng> result = [];
  for (int i = 0; i < list.length; i++) {
    result.add(convertPoint(list[i]));
  }
  return result;
}

Color convertHex(String hex) {
  hex = hex.replaceFirst('#', '');
  final buffer = StringBuffer();
  buffer.write('ff');
  buffer.write(hex);

  return Color(int.parse(buffer.toString(), radix: 16));
}

List<Polyline> processPolylines(List<route.Step> steps) {
  List<Polyline> result = [];
  for (int i = 0; i < steps.length; i++) {
    route.Step s = steps[i];
    if (s.travelMode == "WALKING") {
      result.add(Polyline(
        polylineId: PolylineId('$i'),
        color: Colors.grey,
        patterns: const [PatternItem.dot],
        points: convertPoints(s.polyline),
        width: 5,
      ));
    } else if (s.travelMode == "TRANSIT") {
      result.add(Polyline(
        polylineId: PolylineId('$i'),
        color: convertHex(s.transitDetails?.line.color ?? '#000000'),
        points: convertPoints(s.polyline),
        width: 5,
      ));
    }
  }

  return result;
}
