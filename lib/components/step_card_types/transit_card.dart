import 'package:application/components/shorthand.dart';
import 'package:application/models/route.dart';
import 'package:application/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TransitCard extends StatefulWidget {
  final TransitDetails? transitDetails;
  const TransitCard({required this.transitDetails, Key? key}) : super(key: key);

  @override
  _TransitCardState createState() => _TransitCardState();
}

class _TransitCardState extends State<TransitCard> {
  bool showStations = false;

  void toggleStations() {
    setState(() {
      showStations = !showStations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Shorthand(
              transit: true,
              duration: "20 min",
              line: Line(color: "#ff0000", name: "M1", vehicleType: "SUBWAY"),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Take the M1 Train",
                      style:
                          TextStyle(fontFamily: "UberMoveBold", fontSize: 20),
                    ),
                    Text(
                      "7 min",
                      style: TextStyle(
                          fontFamily: "UberMoveBold",
                          fontSize: 20,
                          color: Colors.green),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Towards Preciziei",
                      style: TextStyle(
                          fontFamily: "UberMoveMedium",
                          fontSize: 16,
                          color: darkGrey),
                    ),
                    Text(
                      "On Time",
                      style: TextStyle(
                          fontFamily: "UberMoveMedium",
                          fontSize: 12,
                          color: Colors.green),
                    )
                  ],
                ),
                SizedBox(height: 10),
                // Container to hold the yellow line and stations
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.amber,
                          width: 8,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          // First station
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Gara de Nord",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: "UberMoveBold"),
                              ),
                              Text(
                                "12:30",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "UberMoveMedium",
                                    color: darkGrey),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: toggleStations,
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Go 5 stops, 14 min",
                                    style: TextStyle(
                                        fontFamily: "UberMoveMedium",
                                        fontSize: 16,
                                        color: Colors.blue),
                                  ),
                                  Icon(
                                    showStations
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (showStations)
                            Container(
                              height: 140,
                              child: FixedTimeline.tileBuilder(
                                theme: TimelineThemeData(
                                  nodePosition: 0,
                                  indicatorTheme: IndicatorThemeData(
                                      size: 20, color: Colors.black),
                                  connectorTheme:
                                      ConnectorThemeData(thickness: 2),
                                ),
                                builder: TimelineTileBuilder.connected(
                                  connectionDirection:
                                      ConnectionDirection.before,
                                  contentsAlign: ContentsAlign.basic,
                                  indicatorBuilder: (context, index) {
                                    return OutlinedDotIndicator(
                                      borderWidth: 4,
                                      color: Colors.amber,
                                    );
                                  },
                                  connectorBuilder: (context, index, type) {
                                    return SolidLineConnector(
                                      color: Colors.amber,
                                      thickness: 4,
                                    );
                                  },
                                  contentsBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Station ${index + 1}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "UberMoveBold"),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "12:${30 + index + 1}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "UberMoveMedium",
                                              color: darkGrey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  itemCount: 5,
                                ),
                              ),
                            ),
                          SizedBox(height: 10),
                          // Last station
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Eroilor",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: "UberMoveBold"),
                              ),
                              Text(
                                "12:44",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "UberMoveMedium",
                                    color: darkGrey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
