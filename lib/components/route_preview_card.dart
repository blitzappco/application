import 'dart:async';

import 'package:blitz/utils/normalize.dart';
import 'package:blitz/utils/shorthand.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:blitz/bifrost/core/models/route.dart' as r;

class RoutePreviewCard extends StatelessWidget {
  final Future<void> Function() tap;
  final Future<void> Function() go;

  final r.Route route;
  const RoutePreviewCard(
      {required this.tap, required this.go, required this.route, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await tap();
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  normalizeDuration(route.leg.duration.value),
                  style:
                      const TextStyle(fontFamily: 'UberMoveBold', fontSize: 23),
                ),
                Row(
                  children: [
                    Text(
                      route.leg.steps[0].travelMode == "TRANSIT"
                          ? 'Leaves at ${normalizeTime(route.leg.departureTime.text)}'
                          : 'Leave now',
                      style: const TextStyle(
                          fontFamily: 'UberMove',
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                    Transform.rotate(
                      angle: 45 * 3.141592653589793 / 180,
                      child: Lottie.network(
                          'https://lottie.host/1e2cd4a1-120e-4f95-8b15-2257bf2e9a1b/j8iPCwLDUL.json',
                          height: 20,
                          width: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                //Here is the problem
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Wrap(
                    spacing:
                        0.0, // Adjust the spacing between elements as needed
                    runSpacing: 8.0, // Adjust the run spacing as needed
                    children: processShorthands(route.leg.steps),
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () async {
                await tap();
                await go();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF44D55B),
                    borderRadius: BorderRadius.circular(12)),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Go',
                    style: TextStyle(
                        fontFamily: 'UberMoveBold',
                        color: Colors.white,
                        fontSize: 22),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
