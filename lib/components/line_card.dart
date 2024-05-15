import 'package:application/components/shorthand.dart';
import 'package:application/utils/env.dart';
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
            isWalk: false,
            time: 20,
            lineName: '21',
            lineType: "BUS",
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dristor 2",
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
