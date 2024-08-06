import 'package:blitz/components/shorthand.dart';
import 'package:blitz/bifrost/core/models/route.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

class LineCard extends StatelessWidget {
  const LineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Shorthand(
              transit: true,
              duration: "",
              line: Line(color: "#ff0000", name: "24", vehicleType: "BUS")),
          const SizedBox(
            width: 20,
          ),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dristor 2',
                      style:
                          TextStyle(fontSize: 20, fontFamily: 'UberMoveBold'),
                    ),
                    Text(
                      "Now, 3min",
                      style:
                          TextStyle(fontSize: 20, fontFamily: 'UberMoveMedium'),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Every 4 min",
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 16,
                          fontFamily: 'UberMoveMedium'),
                    ),
                    Text(
                      "Scheduled",
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 16,
                          fontFamily: 'UberMoveMedium'),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
