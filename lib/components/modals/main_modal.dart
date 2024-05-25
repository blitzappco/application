import 'package:blitz/components/active_train_ticket.dart';
import 'package:blitz/components/modals/profile_modal.dart';
import 'package:blitz/components/modals/wallet_modal.dart';
import 'package:blitz/components/nearby_stations.dart';
import 'package:blitz/components/place_list.dart';
import 'package:blitz/components/static_searchbar.dart';
import 'package:blitz/models/place.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/route_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MainModal extends StatelessWidget {
  final GoogleMapController mapController;
  const MainModal({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final controller = DraggableScrollableController();
    return Consumer<AccountProvider>(builder: (context, account, _) {
      return Consumer<RouteProvider>(builder: (context, route, _) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.9,
          minChildSize: 0.19,
          snap: true,
          snapSizes: const [0.19, 0.48, 0.9],
          controller: controller,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: const BoxDecoration(
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
                                const Text(
                                  'Home',
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
                                      child: const Icon(
                                        Icons.wallet,
                                        size: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        ProfileModal.show(context);
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/moaca.png'),
                                              fit: BoxFit.fill,
                                            ),
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
                            const SizedBox(
                              height: 10,
                            ),
                            const StaticSearchbar(),
                            const SizedBox(
                              height: 35,
                            ),

                            const ActiveTrainTicket(),
                            const SizedBox(
                              height: 15,
                            ),
                            const Divider(
                              color: lightGrey,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Nearby stations
                            const Row(
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
                            const SizedBox(
                              height: 10,
                            ),
                            const NearbyStations(),
                            //Recents
                            const SizedBox(
                              height: 15,
                            ),
                            // Nearby stations
                            const Row(
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
                            const SizedBox(
                              height: 10,
                            ),

                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: PlaceList(
                                    places: account.account.trips ?? [],
                                    set: route.setTo,
                                    trip: (Place p) async {},
                                    callback: () {},
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
    });
  }
}
