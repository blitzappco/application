import 'package:blitz/components/search/place_list.dart';
import 'package:blitz/bifrost/core/models/place.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/vars.dart';

class LabelModal {
  static void show(BuildContext context, String type) {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();

    bool unfocused = true;

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
          if (unfocused) FocusScope.of(context).requestFocus(focusNode);
          unfocused = false;
        });

        return Consumer<AccountProvider>(builder: (context, auth, _) {
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
                        const Text(
                          "Cauta",
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
                              route.clearPredictions();
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
                                      decoration:
                                          const InputDecoration.collapsed(
                                        hintText: "Cauta o locatie",
                                        hintStyle: TextStyle(
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
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (route.predictions.isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 209, 209, 209)
                                  .withOpacity(0.5),
                              spreadRadius: -1,
                              blurRadius: 9,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: PlaceList(
                            places: (route.predictions),
                            set: (Place p) async {
                              await auth.setLabelPlace(p);
                            },
                            trip: (Place p) async {
                              route.clearPredictions();
                            },
                            callback: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
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
