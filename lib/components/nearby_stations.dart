import 'package:blitz/components/station_card.dart';
import 'package:blitz/models/route.dart';
import 'package:flutter/material.dart';

class NearbyStations extends StatelessWidget {
  const NearbyStations({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 145,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            StationCard(
              distance: '617 meters',
              name: 'Politehnica',
              line1: Line(color: '#ED1A3A', name: 'M3', vehicleType: "SUBWAY"),
              line2: Line(color: '#1d71b8', name: '61', vehicleType: "BUS"),
            ),
            StationCard(
              distance: '958 meters',
              name: 'Grozavesti',
              line1: Line(color: '#F2B70A', name: 'M1', vehicleType: "SUBWAY"),
              line2: Line(color: '#EE292F', name: '1', vehicleType: "TRAM"),
            ),
            StationCard(
              distance: '765 meters',
              name: 'Complex Regie',
              line1: Line(color: '#2D2E83', name: 'N110', vehicleType: "BUS"),
              line2: Line(color: '#1d71b8', name: '90', vehicleType: "BUS"),
            ),
          ],
        ));
  }
}
