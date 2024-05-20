import 'package:application/utils/polyline.dart';
import 'package:application/models/route.dart';
import 'package:application/utils/env.dart';
import 'package:flutter/material.dart';

class GoStationCard extends StatelessWidget {
  final Line line;
  final String headsign;
  const GoStationCard({required this.line, required this.headsign, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(Icons.login_rounded, size: 35),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Go to platform",
                    style: TextStyle(fontSize: 18, fontFamily: "UberMoveBold"),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: convertHex(line.color)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 7),
                          child: Text(
                            line.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'UberMoveBold',
                                fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "to $headsign",
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "UberMoveMedium",
                            color: darkGrey),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 172, 172, 172),
                      )),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      children: [
                        Transform.rotate(
                          angle: -45 * 3.1415926535897932 / 180,
                          child: const Icon(
                            Icons.navigation_rounded,
                            size: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Navigate",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
