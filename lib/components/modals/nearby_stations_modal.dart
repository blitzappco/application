import 'package:application/components/line_card.dart';
import 'package:application/components/shorthand.dart';
import 'package:application/models/route.dart';
import 'package:application/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                      Text(
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
                  Row(
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
                  SizedBox(
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
                      SizedBox(
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
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
                  SizedBox(
                    height: 30,
                  ),
                  Row(
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
                  Container(
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
