import 'package:application/components/modals/nearby_stations_modal.dart';
import 'package:application/components/shorthand.dart';
import 'package:application/utils/env.dart';
import 'package:flutter/material.dart';

class StationCard extends StatelessWidget {
  final String stationName;
  final String stationDistance;
  final String Shorthand1;
  final String Shorthand2;
  const StationCard(
      {required this.stationName,
      required this.stationDistance,
      required this.Shorthand1,
      required this.Shorthand2,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NearbyStationModal.show(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 145),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stationName,
                        style:
                            TextStyle(fontSize: 16, fontFamily: 'UberMoveBold'),
                      ),
                      Text(
                        stationDistance,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'UberMoveMedium',
                            color: darkGrey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Row(
                    children: [
                      Shorthand(
                        isWalk: false,
                        time: 20,
                        lineName: '21',
                        lineType: "BUS",
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Shorthand(
                        isWalk: false,
                        time: 20,
                        lineName: '21',
                        lineType: "BUS",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
