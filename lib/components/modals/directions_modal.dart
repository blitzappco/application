import 'package:application/components/active_train_ticket.dart';
import 'package:application/components/modals/departures_modal.dart';
import 'package:application/components/modals/profile_modal.dart';
import 'package:application/components/nearby_stations.dart';
import 'package:application/components/place_list.dart';
import 'package:application/components/static_searchbar.dart';
import 'package:application/components/step_card_types/step_card.dart';
import 'package:application/providers/route_provider.dart';
import 'package:application/utils/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DirectionsModal extends StatelessWidget {
  late GoogleMapController mapController;
  DirectionsModal({super.key, required this.mapController});

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
          return Container(
            decoration: BoxDecoration(
              color: Color(0xFFF8F8F8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '37 min • Arrival time: 14:32',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "UberMoveMedium",
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: lightGrey,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
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
                  ),
                ),
                SliverToBoxAdapter(
                  child: const Divider(),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${route.routes[route.routeIndex].leg.duration.text} • Arrival time: ${route.routes[route.routeIndex].leg.arrivalTime.text}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "UberMoveMedium"),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: lightGrey),
                                  child: GestureDetector(
                                    onTap: () {
                                      route.changeLoading(true);
                                      route.changePage('preview');
                                      route.changeLoading(false);
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
                          ),
                          const SizedBox(height: 5),
                          const Divider(),
                          ListView.separated(
                            itemCount: route.stepCards.length,
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return route.stepCards[index];
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                    childCount: route.stepCards.length,
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
