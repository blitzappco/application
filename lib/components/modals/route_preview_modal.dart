import 'package:application/components/route_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../maps/map_controller.dart';
import '../../utils/env.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        minChildSize: 0.4,
        initialChildSize: 0.4,
        maxChildSize: 0.9,
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
                          Text(
                            "Routes",
                            style: TextStyle(
                              fontFamily: "UberMoveBold",
                              fontSize: 26,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: lightGrey),
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: Color.fromARGB(255, 237, 237, 237)),
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
                                      "shorte",
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
                                      color: Color.fromARGB(255, 211, 211, 211),
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
                                      "cCA",
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
                      SizedBox(
                        height: 20,
                      ),
                      Container(
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
                              itemCount: 4,
                              separatorBuilder: (context, index) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Divider(
                                    color: Color.fromARGB(255, 235, 235, 235),
                                  ),
                                );
                              },
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return RoutePreviewCard(callback: () async {
                                  draggableController.animateTo(0.4,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeOutExpo);
                                  scrollController.animateTo(0,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeOutExpo);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          );
        });
  }
}