import 'package:application/components/place_card.dart';
import 'package:flutter/material.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.separated(
          physics: FixedExtentScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return PlaceCard(
              PlaceName: "Universitatea Politehnica",
              PlaceAddrees: "Splaiul Independentei, 313, Bucharest",
              IconColor: Colors.amber,
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
