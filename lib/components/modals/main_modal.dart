import 'package:blitz/components/buy_ticket_prompt.dart';
import 'package:blitz/components/modals/profile_modal.dart';
import 'package:blitz/components/nearby_stations.dart';
import 'package:blitz/components/search/place_list.dart';
import 'package:blitz/components/static_searchbar.dart';
import 'package:blitz/components/ticket_preview.dart';
import 'package:blitz/bifrost/core/models/place.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/route_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
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
    return Consumer<AccountProvider>(builder: (context, auth, _) {
      return Consumer<RouteProvider>(builder: (context, route, _) {
        return Consumer<TicketsProvider>(builder: (context, tickets, _) {
          return DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 0.9,
            minChildSize: 0.25,
            snap: true,
            snapSizes: const [0.25, 0.48, 0.9],
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
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: StaticSearchbar(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              // const ActiveTrainTicket(),
                              GestureDetector(
                                onTap: () {
                                  ProfileModal.show(context);
                                },
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Bilete",
                                        style: TextStyle(
                                            color: darkGrey,
                                            fontSize: 14,
                                            fontFamily: 'UberMoveMedium'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              tickets.show
                                  ? const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: TicketPreview(activeTicket: true),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: BuyTicketPrompt(),
                                    ),

                              const SizedBox(
                                height: 20,
                              ),
                              // Nearby stations
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Statii in apropiere",
                                      style: TextStyle(
                                          color: darkGrey,
                                          fontSize: 14,
                                          fontFamily: 'UberMoveMedium'),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: NearbyStations(),
                              ),
                              //Recents
                              const SizedBox(
                                height: 15,
                              ),
                              // Nearby stations
                              auth.account.trips != null &&
                                      auth.account.trips!.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Recente",
                                                style: TextStyle(
                                                    color: darkGrey,
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'UberMoveMedium'),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: PlaceList(
                                                  places:
                                                      auth.account.trips ?? [],
                                                  set: route.setTo,
                                                  trip: (Place p) async {},
                                                  callback: () async {
                                                    await route
                                                        .changePage("preview");
                                                    await route.getRoutes();
                                                  },
                                                ),
                                              )),
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
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
    });
  }
}



// GestureDetector(
//                                       onTap: () {
//                                         ProfileModal.show(context);
//                                       },
//                                       child: Container(
//                                         decoration: const BoxDecoration(
//                                             image: DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/images/moaca.png'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                             shape: BoxShape.circle,
//                                             color: Colors.blue),
//                                         width: 37,
//                                         height: 37,
//                                       ),
//                                     )