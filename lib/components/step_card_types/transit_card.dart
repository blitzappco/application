import 'package:blitz/components/shorthand.dart';
import 'package:blitz/models/route.dart';
import 'package:blitz/utils/normalize.dart';
import 'package:blitz/utils/polyline.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TransitCard extends StatefulWidget {
  final TransitDetails? transitDetails;
  final int duration;
  const TransitCard(
      {required this.transitDetails, required this.duration, super.key});

  @override
  State<TransitCard> createState() => _TransitCardState();
}

class _TransitCardState extends State<TransitCard> {
  bool showStations = false;
  bool featureFlag = false;

  void toggleStations() {
    setState(() {
      showStations = !showStations;
    });
  }

  @override
  Widget build(BuildContext context) {
    int numStops = widget.transitDetails?.numStops ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Shorthand(
              transit: true,
              duration: "",
              line: widget.transitDetails?.line ??
                  Line(color: "#ff0000", name: "M1", vehicleType: "SUBWAY"),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Take the ${widget.transitDetails?.line.name ?? ''}"
                      " ${widget.transitDetails?.line.vehicleType.toLowerCase()}",
                      style: const TextStyle(
                          fontFamily: "UberMoveBold", fontSize: 20),
                    ),
                    Text(
                      normalizeTime(
                          widget.transitDetails?.departureTime.text ?? ''),
                      style: const TextStyle(
                          fontFamily: "UberMoveBold",
                          fontSize: 20,
                          color: Colors.green),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Wrap(children: [
                        Text(
                          "Towards ${widget.transitDetails?.headsign}",
                          style: const TextStyle(
                              fontFamily: "UberMoveMedium",
                              fontSize: 16,
                              color: darkGrey),
                        ),
                      ]),
                    ),
                    const Text(
                      "On Time",
                      style: TextStyle(
                          fontFamily: "UberMoveMedium",
                          fontSize: 12,
                          color: Colors.green),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                // Container to hold the yellow line and stations
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: convertHex(
                              widget.transitDetails?.line.color ?? '#ff0000'),
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
                                widget.transitDetails?.departureStop.name ?? '',
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: "UberMoveBold"),
                              ),
                              Text(
                                normalizeTime(
                                    widget.transitDetails?.departureTime.text ??
                                        ''),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "UberMoveMedium",
                                    color: darkGrey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: toggleStations,
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    numStops != 1
                                        ? "Go $numStops stops, ${normalizeDuration(widget.duration)}"
                                        : "Go 1 stop, ${normalizeDuration(widget.duration)}",
                                    style: const TextStyle(
                                        fontFamily: "UberMoveMedium",
                                        fontSize: 16,
                                        color: Colors.blue),
                                  ),
                                  if (featureFlag)
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
                          if (showStations && featureFlag)
                            FixedTimeline.tileBuilder(
                              theme: TimelineThemeData(
                                nodePosition: 0,
                                indicatorTheme: const IndicatorThemeData(
                                    size: 20, color: Colors.black),
                                connectorTheme:
                                    const ConnectorThemeData(thickness: 2),
                              ),
                              builder: TimelineTileBuilder.connected(
                                connectionDirection: ConnectionDirection.before,
                                contentsAlign: ContentsAlign.basic,
                                indicatorBuilder: (context, index) {
                                  return OutlinedDotIndicator(
                                    borderWidth: 4,
                                    color: convertHex(
                                        widget.transitDetails?.line.color ??
                                            '#ff0000'),
                                  );
                                },
                                connectorBuilder: (context, index, type) {
                                  return SolidLineConnector(
                                    color: convertHex(
                                        widget.transitDetails?.line.color ??
                                            '#ff0000'),
                                    thickness: 4,
                                  );
                                },
                                contentsBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 5, bottom: 5),
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
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontFamily: "UberMoveMedium"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                itemCount: numStops - 1,
                              ),
                            ),
                          const SizedBox(height: 10),
                          // Last station
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.transitDetails?.arrivalStop.name ?? '',
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: "UberMoveBold"),
                              ),
                              Text(
                                normalizeTime(
                                    widget.transitDetails?.arrivalTime.text ??
                                        ''),
                                style: const TextStyle(
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
