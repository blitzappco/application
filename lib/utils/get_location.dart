import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled
    return null;
  }

  // Request location permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    // Location permissions are permanently denied, handle accordingly
    return null;
  }

  if (permission == LocationPermission.denied) {
    // Location permissions are denied, ask for permission
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      // Location permissions are not granted, handle accordingly
      return null;
    }
  }

  // Retrieve the current position
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.bestForNavigation,
  );

  return position;
}
