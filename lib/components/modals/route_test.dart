import 'package:blitz/pages/indoor_nav.dart';
import 'package:blitz/providers/route_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class RouteTest extends StatelessWidget {
  final GoogleMapController mapController;
  const RouteTest({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final controller = DraggableScrollableController();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => IndoorNavPage()));
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.wallet_rounded,
                                color: Colors.white,
                                size: 35,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
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
                          horizontal: 0, vertical: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '37 min • Arrival time: 14:32',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "UberMoveMedium"),
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
