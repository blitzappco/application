import 'package:application/components/place_card.dart';
import 'package:application/models/place.dart';
import 'package:application/utils/types.dart';
import 'package:flutter/material.dart';
import '../utils/shorten.dart';

class PlaceList extends StatelessWidget {
  final List<Place> places;
  const PlaceList({required this.places, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.separated(
          physics: FixedExtentScrollPhysics(),
          itemCount: places.length,
          itemBuilder: (context, index) {
            return PlaceCard(
              mainText: shorten(places[index].mainText, 35),
              secondaryText: shorten(places[index].secondaryText ?? '', 35),
              type: processTypes(places[index].types),
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
  }
}
