import 'package:application/components/eta_element.dart';
import 'package:application/components/shorthand.dart';
import 'package:application/models/route.dart';
import 'package:application/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timelines_plus/timelines_plus.dart';

class DeparturesModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
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
              height: 500,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.amber),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              child: Text(
                                "M1",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'UberMoveBold',
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Metroul M1",
                                style: TextStyle(
                                  fontFamily: "UberMoveBold",
                                  fontSize: 26,
                                ),
                              ),
                              Text(
                                "Dristor 2 spre Preciziei",
                                style: TextStyle(
                                    fontFamily: "UberMoveMedium",
                                    fontSize: 14,
                                    color: darkGrey),
                              ),
                            ],
                          ),
                        ],
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
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Departures",
                        style: TextStyle(
                          fontFamily: "UberMoveBold",
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Every 5 min",
                        style: TextStyle(
                            fontFamily: "UberMoveMedium",
                            fontSize: 15,
                            color: darkGrey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 65,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        EtaElement(),
                        EtaElement(),
                        EtaElement(),
                        EtaElement(),
                        EtaElement(),
                        EtaElement(),
                        EtaElement(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Stops",
                        style: TextStyle(
                          fontFamily: "UberMoveBold",
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 265,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FixedTimeline.tileBuilder(
                        theme: TimelineThemeData(
                            nodePosition: 0,
                            indicatorTheme: IndicatorThemeData(
                                size: 20, color: Colors.black),
                            connectorTheme: ConnectorThemeData(thickness: 2)),
                        builder: TimelineTileBuilder.connected(
                          connectionDirection: ConnectionDirection.before,
                          contentsAlign: ContentsAlign.basic,
                          indicatorBuilder: (context, index) {
                            return OutlinedDotIndicator(
                              borderWidth: 4,
                              color: index < 2 ? Colors.grey : Colors.amber,
                            );
                          },
                          connectorBuilder: (context, index, type) {
                            return SolidLineConnector(
                              color: index < 2 ? Colors.grey : Colors.amber,
                              thickness: 4,
                            );
                          },
                          contentsBuilder: (context, index) => Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Piata Victoriei",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "UberMoveBold"),
                                    ),
                                    Row(
                                      children: [
                                        Shorthand(
                                            transit: true,
                                            duration: "20 min",
                                            line: Line(
                                                color: "#ff0000",
                                                name: "24",
                                                vehicleType: "BUS"))
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  "23:23",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "UberMoveMedium"),
                                ),
                              ],
                            ),
                          ),
                          itemCount: 3,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
