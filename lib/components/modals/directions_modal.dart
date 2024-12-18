import 'package:blitz/components/modals/ticket_details_modal.dart';
import 'package:blitz/pages/ticket_flow/buy_ticket.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/route_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/normalize.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DirectionsModal extends StatelessWidget {
  final GoogleMapController mapController;
  const DirectionsModal({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final controller = DraggableScrollableController();
    return Consumer<AccountProvider>(builder: (context, auth, _) {
      return Consumer<TicketsProvider>(builder: (context, tickets, _) {
        return Consumer<RouteProvider>(builder: (context, route, _) {
          return DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 0.9,
            minChildSize: 0.19,
            snap: true,
            snapSizes: const [0.19, 0.48, 0.9],
            controller: controller,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
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
                            left: 20, right: 20, top: 13, bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                route.changePage("preview");
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${normalizeDuration(route.routes[route.routeIndex].leg.duration.value)} ',
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: "UberMoveBold"),
                                  ),
                                  Text(
                                    'Arrival time: ${normalizeTime(route.routes[route.routeIndex].leg.arrivalTime!.text)}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "UberMoveMedium"),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 102, 91, 252),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(30)),
                              child: GestureDetector(
                                onTap: () {
                                  tickets.show
                                      ? () async {
                                          if (tickets.last.expiresAt!
                                              .isBefore(DateTime.now())) {
                                            tickets
                                                .validateTicket(auth.token,
                                                    tickets.last.id!)
                                                .then((_) async =>
                                                    TicketDetailsModal.show(
                                                        context));
                                          } else {
                                            TicketDetailsModal.show(context);
                                          }
                                        }()
                                      : BuyTicket.show(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Row(
                                    children: [
                                      tickets.show
                                          ? Row(
                                              children: [
                                                // tickets.loading
                                                tickets.loading
                                                    ? const SizedBox(
                                                        width: 23,
                                                        height: 23,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 2,
                                                        ),
                                                      )
                                                    : const Icon(
                                                        Icons
                                                            .confirmation_num_rounded,
                                                        color: Colors.white,
                                                      ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                      Text(
                                        tickets.show ? "Ticket" : "Buy ticket",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "UberMoveMedium",
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Divider(),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Column(children: [
                            route.stepCards[index],
                            if (index < route.stepCards.length - 1)
                              const Divider(),
                          ]);
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
      });
    });
  }
}
