import 'package:application/components/place_list.dart';
import 'package:application/components/suggestions_icon.dart';
import 'package:application/models/place.dart';
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

        return Consumer<RouteProvider>(builder: (context, route, _) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
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
                          fontSize: 32,
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
                  Container(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SuggestionsIcon(),
                        SuggestionsIcon(),
                        SuggestionsIcon(),
                        SuggestionsIcon(),
                        SuggestionsIcon(),
                        SuggestionsIcon(),
                        SuggestionsIcon(),
                        SuggestionsIcon(),
                        SuggestionsIcon(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (controller.text.isEmpty)
                    PlaceList(
                      places: const [],
                      set: route.setTo,
                    ),
                  if (controller.text.isNotEmpty)
                    PlaceList(
                      places: route.predictions,
                      set: route.setTo,
                    ),
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
      },
    );
  }
}
