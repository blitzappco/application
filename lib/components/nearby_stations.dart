import 'package:blitz/components/station_card.dart';
import 'package:blitz/models/route.dart';
import 'package:flutter/material.dart';

class NearbyStations extends StatelessWidget {
  const NearbyStations({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 145,
        // child: ListView.builder(
        //   itemCount: 1,
        //   scrollDirection: Axis.horizontal,
        //   itemBuilder: (context, index) {
        //     return StationCard(
        //       distance: '100 meters',
        //       name: 'Piata Operei',
        //       line1:
        //           Line(color: '#008d36', name: '85', vehicleType: "TROLLEY"),
        //       line2: Line(color: '#1d71b8', name: '178', vehicleType: "BUS"),
        //     );
        //   },
        // ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            StationCard(
              distance: '57 meters',
              name: 'Universitate',
              line1: Line(color: '#008d36', name: '85', vehicleType: "TROLLEY"),
              line2: Line(color: '#1d71b8', name: '178', vehicleType: "BUS"),
            ),
            StationCard(
              distance: '535 meters',
              name: 'Piata Victoriei',
              line1: Line(color: '#ff0000', name: '44', vehicleType: "TRAM"),
              line2: Line(color: '#1d71b8', name: '178', vehicleType: "BUS"),
            ),
            StationCard(
              distance: '250 meters',
              name: 'Piata 21 Decembrie 1969',
              line1: Line(color: '#008d36', name: '85', vehicleType: "TROLLEY"),
              line2: Line(color: '#1d71b8', name: '100', vehicleType: "BUS"),
            ),
          ],
        ));
  }
}
