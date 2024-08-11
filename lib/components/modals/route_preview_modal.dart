import 'dart:async';

import 'package:blitz/components/route_preview_card.dart';
import 'package:blitz/providers/route_provider.dart';
import 'package:blitz/utils/shorten.dart';
import 'package:blitz/utils/station_marker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../maps/map_controller.dart';
import '../../utils/vars.dart';
import 'search_modal.dart';

class RoutePreviewModal extends StatefulWidget {
  final GoogleMapController mapController;
  const RoutePreviewModal({required this.mapController, super.key});

  @override
  State<RoutePreviewModal> createState() => _RoutePreviewModalState();
}

class _RoutePreviewModalState extends State<RoutePreviewModal> {
  final draggableController = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final route = Provider.of<RouteProvider>(context, listen: false);
      if (route.routes.isNotEmpty) {
        final bounds = route.routes[route.routeIndex].bounds;

        final startLocation = route.routes[0].leg.startLocation;
        final endLocation = route.routes[0].leg.endLocation;

        final startMarker = Marker(
          markerId: const MarkerId('start'),
          position: LatLng(startLocation.latitude, startLocation.longitude),
          infoWindow: const InfoWindow(title: "Start Location"),
        );

        final endMarker = Marker(
          markerId: const MarkerId('end'),
          position: LatLng(endLocation.latitude, endLocation.longitude),
          infoWindow: const InfoWindow(title: "End Location"),
        );

        route.setMarkers({startMarker, endMarker});

        await setCameraBounds(
          widget.mapController,
          LatLngBounds(
              northeast: bounds.northEast, southwest: bounds.southWest),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteProvider>(builder: (context, route, _) {
      return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.9,
          minChildSize: 0.19,
          snap: true,
          snapSizes: const [0.19, 0.48, 0.9],
          controller: draggableController,
          builder: (BuildContext context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 247, 247, 247),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                      physics: const ClampingScrollPhysics(),
                      controller: scrollController,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Routes",
                              style: TextStyle(
                                fontFamily: "SFProRounded",
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: lightGrey),
                              child: GestureDetector(
                                onTap: () async {
                                  route.clearMarkers();
                                  await route.unloadPolylines();
                                  await route.changePage("home");
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Icon(
                                    Icons.close,
                                    color: darkGrey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: const Color.fromARGB(255, 237, 237, 237)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15),
                            child: Column(
                              children: [
                                GestureDetector(
                                  // from
                                  onTap: () {
                                    SearchModal.show(context, "from");
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue),
                                        child: const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.navigation_rounded,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        shorten(route.from.mainText, 30),
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'UberMoveMedium',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Row(
                                  children: [
                                    SizedBox(
                                      width: 32,
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color:
                                            Color.fromARGB(255, 211, 211, 211),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  // to
                                  onTap: () {
                                    SearchModal.show(context, "to");
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue),
                                        child: const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.location_city_rounded,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        shorten(route.to.mainText, 30),
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'UberMoveMedium',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        (route.routes.isNotEmpty)
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(9)),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: MediaQuery.removePadding(
                                    removeBottom: true,
                                    removeTop: true,
                                    context: context,
                                    child: ListView.separated(
                                      itemCount: route.routes.length,
                                      separatorBuilder: (context, index) {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Divider(
                                            color: Color.fromARGB(
                                                255, 235, 235, 235),
                                          ),
                                        );
                                      },
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return RoutePreviewCard(
                                            route: route.routes[index],
                                            tap: () async {
                                              draggableController.animateTo(0.4,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeOutExpo);
                                              scrollController.animateTo(0,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeOutExpo);

                                              await route
                                                  .changeRouteIndex(index);

                                              final bounds = route
                                                  .routes[route.routeIndex]
                                                  .bounds;

                                              await setCameraBounds(
                                                widget.mapController,
                                                LatLngBounds(
                                                    northeast: bounds.northEast,
                                                    southwest:
                                                        bounds.southWest),
                                              );
                                            },
                                            go: () async {
                                              Timer(
                                                  const Duration(
                                                      milliseconds: 350),
                                                  () async {
                                                await route
                                                    .changePage("directions");
                                              });
                                            });
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Icon(
                                      CupertinoIcons
                                          .exclamationmark_circle_fill,
                                      color: darkGrey,
                                      size: 30,
                                    ),
                                    Text(
                                      "Nu exista rute ce contin mijloace de transport",
                                      style: TextStyle(
                                          fontFamily: "SFProRounded",
                                          fontSize: 16,
                                          color: darkGrey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                      ]),
                ),
              ),
            );
          });
    });
  }
}
