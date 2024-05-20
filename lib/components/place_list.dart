import 'package:application/components/place_card.dart';
import 'package:application/models/place.dart';
import 'package:application/pages/homescreen.dart';
import 'package:application/providers/route_provider.dart';
import 'package:application/utils/types.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/shorten.dart';

class PlaceList extends StatelessWidget {
  final List<Place> places;
  final Future<void> Function(Place p) set;
  const PlaceList({required this.places, required this.set, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteProvider>(builder: (context, route, _) {
      return SizedBox(
        height: 110,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: ListView.separated(
            physics: const FixedExtentScrollPhysics(),
            itemCount: places.length,
            itemBuilder: (context, index) {
              return PlaceCard(
                mainText: shorten(places[index].mainText, 35),
                secondaryText: shorten(places[index].secondaryText ?? '', 35),
                type: processTypes(places[index].types),
                callback: () async {
                  await set(places[index]);

                  Navigator.pop(context);

                  await route.changePage("preview");
                  await route.getRoutes();
                },
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  color: Colors.grey[100],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
