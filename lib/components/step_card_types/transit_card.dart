import 'package:application/components/shorthand.dart';
import 'package:application/models/route.dart';
import 'package:application/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TransitCard extends StatelessWidget {
  final TransitDetails? transitDetails;
  const TransitCard({required this.transitDetails, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Shorthand(
              transit: true,
              duration: "20 min",
              line: Line(color: "#ff0000", name: "M1", vehicleType: "SUBWAY")),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Take the M1 Train",
                  style: TextStyle(fontFamily: "UberMoveBold", fontSize: 20),
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
            SizedBox(
              height: 20,
            ),
            Container(
              height: 140,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
              child: FixedTimeline.tileBuilder(
                theme: TimelineThemeData(
                    nodePosition: 0,
                    indicatorTheme:
                        IndicatorThemeData(size: 20, color: Colors.black),
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
                    padding: const EdgeInsets.only(left: 8.0, bottom: 20),
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
                                  fontSize: 18, fontFamily: "UberMoveBold"),
                            ),
                          ],
                        ),
                        Text(
                          "23:23",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "UberMoveMedium",
                              color: darkGrey),
                        ),
                      ],
                    ),
                  ),
                  itemCount: 2,
                ),
              ),
            )
          ]),
        )
      ]),
    );
  }
}
