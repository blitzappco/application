import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/get_location.dart';

setCameraLocation(GoogleMapController mapController) async {
  final pos = await getCurrentLocation();
  CameraPosition cp = CameraPosition(
      target: LatLng(
        pos?.latitude ?? 0.0,
        pos?.longitude ?? 0.0,
      ),
      zoom: 17);
  mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
}

setCamera(GoogleMapController mapController, LatLng latlng) {
  CameraPosition cp = CameraPosition(target: latlng, zoom: 17);
  mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
}

setCameraBounds(GoogleMapController mapController, LatLngBounds bounds) async {
  mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
}

setNavMode(
    GoogleMapController mapController, LatLng latlng, double bearing) async {
  mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    target: latlng,
    bearing: bearing,
    zoom: 18,
  )));
}
