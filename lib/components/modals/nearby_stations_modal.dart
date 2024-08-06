import 'package:blitz/components/line_card.dart';
import 'package:blitz/components/shorthand.dart';
import 'package:blitz/bifrost/core/models/route.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

class NearbyStationModal {
  static void show(BuildContext context) {
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

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              color: Colors.white,
              height: 500,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Piata Operei",
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
                  const Row(
                    children: [
                      Text(
                        "Subway Station · 100 m",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "UberMoveMedium",
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Shorthand(
                          transit: true,
                          duration: "20 min",
                          line: Line(
                              color: "#ff0000",
                              name: "24",
                              vehicleType: "BUS")),
                      const SizedBox(
                        width: 5,
                      ),
                      Shorthand(
                          transit: true,
                          duration: "20 min",
                          line: Line(
                              color: "#ff0000",
                              name: "24",
                              vehicleType: "BUS")),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                'Directions',
                                style: TextStyle(
                                    fontFamily: "UberMoveBold",
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                              Text(
                                "Get there in 3 min by foot",
                                style: TextStyle(
                                    fontFamily: "UberMoveMedium",
                                    color: Colors.white,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      Text(
                        "Departures",
                        style: TextStyle(
                            color: darkGrey,
                            fontSize: 14,
                            fontFamily: 'UberMoveMedium'),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.separated(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const LineCard();
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey[300],
                        );
                      },
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
