import 'dart:async';

import 'package:application/components/modals/directions_modal.dart';
import 'package:application/components/modals/main_modal.dart';
import 'package:application/components/modals/route_preview_modal.dart';
import 'package:application/maps/map_controller.dart';
import 'package:application/utils/get_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late GoogleMapController mapController;

  void setupPositionLocator() async {
    final pos = await getCurrentLocation();

    CameraPosition cp = CameraPosition(
        target: LatLng(
          pos?.latitude ?? 0.0,
          pos?.longitude ?? 0.0,
        ),
        zoom: 17);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            compassEnabled: false,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(44.4364384, 26.0863522),
              zoom: 14.0,
            ),
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
              mapController = controller;
              setCameraLocation(mapController);
            },
          ),
          //Bottom screen
          MainModal(),
          // DirectionsModal(),
          // RoutePreviewModal(
          //   mapController: mapController,
          // ),
        ],
      ),
    );
  }
}
