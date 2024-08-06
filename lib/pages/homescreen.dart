import 'dart:async';

import 'package:blitz/bifrost/core/endpoints.dart';
import 'package:blitz/components/modals/loading.dart';
import 'package:blitz/components/modals/directions_modal.dart';
import 'package:blitz/components/modals/main_modal.dart';
import 'package:blitz/components/modals/route_preview_modal.dart';
import 'package:blitz/components/modals/route_test.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/route_provider.dart';
import 'package:blitz/utils/get_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final route = Provider.of<RouteProvider>(context, listen: false);
      final auth = Provider.of<AccountProvider>(context, listen: false);

      await auth.getLabels();
      await auth.getTrips();

      final from = await geocodeFromAddress("politehnica");
      route.setFrom(from);
    });
  }

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
    return Consumer<RouteProvider>(builder: (context, route, _) {
      return Consumer<AccountProvider>(builder: (context, auth, _) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  polylines: route.polylinesSet,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  zoomGesturesEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapToolbarEnabled: false,
                  padding: EdgeInsets.only(bottom: route.mapPadding),
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(44.43856037994135, 26.049492497879125),
                    zoom: 14.0,
                  ),
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                    mapController = controller;
                    await route.initMap();
                    // setCameraLocation(mapController);
                  },
                ),
                if (route.loading) const Loading(),
                if (route.page == 'home' && !route.loading && route.map)
                  MainModal(
                    mapController: mapController,
                  ),
                if (route.page == 'preview' && !route.loading && route.map)
                  RoutePreviewModal(
                    mapController: mapController,
                  ),
                if (route.page == 'directions' && !route.loading && route.map)
                  DirectionsModal(mapController: mapController),
                if (route.page == 'test' && !route.loading && route.map)
                  // RouteTest(mapController: mapController),
                  RouteTest(mapController: mapController),
                if (route.page == 'directions' && !route.loading && route.map)
                  Positioned(
                      top: 60,
                      left: 20,
                      child: GestureDetector(
                        onTap: () {
                          route.changePage('preview');
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 20,
                              ),
                            )),
                      ))
              ],
            ),
          ),
        );
      });
    });
  }
}
