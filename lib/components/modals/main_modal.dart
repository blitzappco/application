import 'package:application/components/modals/departures_modal.dart';
import 'package:application/components/modals/profile_modal.dart';
import 'package:application/components/modals/wallet_modal.dart';
import 'package:application/components/nearby_stations.dart';
import 'package:application/components/place_list.dart';
import 'package:application/components/static_searchbar.dart';
import 'package:application/providers/route_provider.dart';
import 'package:application/utils/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MainModal extends StatelessWidget {
  late GoogleMapController mapController;
  MainModal({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final _controller = DraggableScrollableController();
    return Consumer<RouteProvider>(builder: (context, route, _) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.9,
        minChildSize: 0.19,
        snap: true,
        snapSizes: [0.19, 0.48, 0.9],
        controller: _controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            controller: scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Route',
                                style: TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'UberMoveBold',
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // DeparturesModal.show(context);
                                      WalletModal.show(context);
                                    },
                                    child: Icon(
                                      Icons.wallet,
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ProfileModal.show(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue),
                                      width: 37,
                                      height: 37,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          StaticSearchbar(),
                          SizedBox(
                            height: 15,
                          ),
                          // Nearby stations
                          Row(
                            children: [
                              Text(
                                "Nearby stations",
                                style: TextStyle(
                                    color: darkGrey,
                                    fontSize: 14,
                                    fontFamily: 'UberMoveMedium'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NearbyStations(),
                          //Recents
                          SizedBox(
                            height: 15,
                          ),
                          // Nearby stations
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recents",
                                style: TextStyle(
                                    color: darkGrey,
                                    fontSize: 14,
                                    fontFamily: 'UberMoveMedium'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: PlaceList(
                                  places: const [],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
