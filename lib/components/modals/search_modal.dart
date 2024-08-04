import 'package:blitz/components/address_label.dart';
import 'package:blitz/components/place_list.dart';
import 'package:blitz/components/suggestions_icon.dart';
import 'package:blitz/models/place.dart';
import 'package:blitz/pages/manage_address.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/route_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../utils/vars.dart';

class SearchModal {
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
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 70,
                      child: Container(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            AddressLabel(
                              label: "Acasa",
                              address: "Seteaza",
                            ),
                            SizedBox(width: 10),
                            AddressLabel(label: "Serviciu", address: "Seteaza"),
                            SizedBox(width: 17),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ManageAddress()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color.fromARGB(
                                        255, 209, 234, 255)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.blue[800],
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (controller.text.isEmpty && type == "to")
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 209, 209, 209)
                                  .withOpacity(0.5),
                              spreadRadius: -1,
                              blurRadius: 9,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: PlaceList(
                            places: account.account.trips ?? [],
                            set: route.setTo,
                            trip: (Place p) async {},
                            callback: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    if (controller.text.isEmpty && type == "from")
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 209, 209, 209)
                                  .withOpacity(0.5),
                              spreadRadius: -1,
                              blurRadius: 9,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: PlaceList(
                            places: account.account.trips ?? [],
                            set: route.setFrom,
                            trip: (Place p) async {},
                            callback: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    if (controller.text.isNotEmpty && type == "to")
                      if (type == "to")
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 209, 209, 209)
                                    .withOpacity(0.5),
                                spreadRadius: -1,
                                blurRadius: 9,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: PlaceList(
                                places: route.predictions,
                                set: route.setTo,
                                trip: account.addTrip,
                                callback: () {
                                  Navigator.pop(context);
                                }),
                          ),
                        ),
                    if (controller.text.isNotEmpty && type == "from")
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 209, 209, 209)
                                  .withOpacity(0.5),
                              spreadRadius: -1,
                              blurRadius: 9,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: PlaceList(
                              places: route.predictions,
                              set: route.setFrom,
                              trip: account.addTrip,
                              callback: () {
                                Navigator.pop(context);
                              }),
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
