import 'package:application/components/place_list.dart';
import 'package:application/components/suggestions_icon.dart';
import 'package:application/models/place.dart';
import 'package:application/providers/account_provider.dart';
import 'package:application/providers/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/vars.dart';

class SearchModal {
  static void show(BuildContext context, String type) {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();

    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(9),
          topRight: Radius.circular(9),
        ),
      ),
      builder: (BuildContext context) {
        // Schedule the focus request after the bottom sheet is built
        WidgetsBinding.instance.addPostFrameCallback((_) {
          FocusScope.of(context).requestFocus(focusNode);
        });

        return Consumer<AccountProvider>(builder: (context, account, _) {
          return Consumer<RouteProvider>(builder: (context, route, _) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Search",
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
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: lightGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (input) async {
                                        await route.getPredictions(input);
                                      },
                                      controller: controller,
                                      focusNode: focusNode,
                                      decoration: InputDecoration.collapsed(
                                        hintText: type == 'to'
                                            ? 'Cauta o destinatie'
                                            : 'Cauta o locatie',
                                        hintStyle: const TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'UberMoveMedium',
                                          color: darkGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10.0),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Navigator.pop(context);
                        //     },
                        //     child: const Text(
                        //       'Cancel',
                        //       style: TextStyle(
                        //         fontSize: 15,
                        //         fontFamily: 'UberMoveMedium',
                        //         color: Colors.blue,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (controller.text.isEmpty)
                      Container(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SuggestionsIcon(type: 'bar', name: "Drinks"),
                            const SuggestionsIcon(
                                type: 'shopping_mall', name: "Malls"),
                            const SuggestionsIcon(
                                type: 'restaurant', name: "Restaurants"),
                            const SuggestionsIcon(
                                type: 'university', name: "Universities"),
                            const SuggestionsIcon(type: 'park', name: "Parks"),
                            const SuggestionsIcon(type: 'cafe', name: "Cafes"),
                            const SuggestionsIcon(
                                type: 'pharmacy', name: "Pharmacies"),
                            const SuggestionsIcon(type: 'bank', name: "Banks"),
                          ],
                        ),
                      ),
                    const SizedBox(height: 7),
                    if (controller.text.isEmpty && type == "to")
                      PlaceList(
                        places: account.account.trips ?? [],
                        set: route.setTo,
                        trip: (Place p) async {},
                        callback: () {
                          Navigator.pop(context);
                        },
                      ),

                    if (controller.text.isEmpty && type == "from")
                      PlaceList(
                        places: account.account.trips ?? [],
                        set: route.setFrom,
                        trip: (Place p) async {},
                        callback: () {
                          Navigator.pop(context);
                        },
                      ),
                    if (controller.text.isNotEmpty && type == "to")
                      if (type == "to")
                        PlaceList(
                            places: route.predictions,
                            set: route.setTo,
                            trip: account.addTrip,
                            callback: () {
                              Navigator.pop(context);
                            }),
                    if (controller.text.isNotEmpty && type == "from")
                      PlaceList(
                          places: route.predictions,
                          set: route.setFrom,
                          trip: account.addTrip,
                          callback: () {
                            Navigator.pop(context);
                          }),
                    // if (controller.text.isNotEmpty)
                    //   Predictions(
                    //       type: type,
                    //       callback: () async {
                    //         Navigator.pop(context);
                    //       })
                    // : Predictions(
                    //     type: type,
                    //     callback: () async {
                    //       Navigator.pop(context);
                    //     }),
                  ],
                ),
              ),
            );
          });
        });
      },
    );
  }
}
