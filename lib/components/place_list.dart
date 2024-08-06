import 'package:blitz/components/place_card.dart';
import 'package:blitz/bifrost/core/models/place.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/route_provider.dart';
import 'package:blitz/utils/types.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/shorten.dart';

class PlaceList extends StatelessWidget {
  final List<Place> places;
  final Future<void> Function(Place p) set;
  final Future<void> Function(Place p) trip;
  final void Function() callback;

  const PlaceList(
      {required this.places,
      required this.set,
      required this.trip,
      required this.callback,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, account, _) {
      return Consumer<RouteProvider>(builder: (context, route, _) {
        return SizedBox(
          height: 185,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: places.length,
              itemBuilder: (context, index) {
                return PlaceCard(
                  mainText: shorten(places[index].mainText, 35),
                  secondaryText: shorten(places[index].secondaryText ?? '', 35),
                  type: processTypes(places[index].types),
                  callback: () async {
                    await set(places[index]);

                    await trip(places[index]);

                    callback();

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
    });
  }
}
