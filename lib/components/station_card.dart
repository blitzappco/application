import 'package:blitz/components/modals/nearby_stations_modal.dart';
import 'package:blitz/components/shorthand.dart';
import 'package:blitz/bifrost/core/models/route.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

class StationCard extends StatelessWidget {
  final String name;
  final String distance;
  final Line line1;
  final Line line2;
  const StationCard(
      {required this.name,
      required this.distance,
      required this.line1,
      required this.line2,
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
          constraints: const BoxConstraints(minWidth: 145),
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
                        name,
                        style: const TextStyle(
                            fontSize: 16, fontFamily: 'UberMoveBold'),
                      ),
                      Text(
                        distance,
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'UberMoveMedium',
                            color: darkGrey),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Row(
                    children: [
                      Shorthand(transit: true, duration: "20 min", line: line1),
                      const SizedBox(
                        width: 3,
                      ),
                      Shorthand(transit: true, duration: "20 min", line: line2),
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
