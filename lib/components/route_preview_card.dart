import 'dart:async';

import 'package:application/components/shorthand.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RoutePreviewCard extends StatelessWidget {
  // // final List<Segment> segments;
  // final Map<String, String> meta;
  // final int index;

  final Future<void> Function() callback;
  const RoutePreviewCard(
      {
      // // required this.segments,
      // required this.meta,
      // required this.index,
      required this.callback,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "23 min",
                style:
                    const TextStyle(fontFamily: 'UberMoveBold', fontSize: 23),
              ),
              Row(
                children: [
                  Text(
                    'Leaves in 3 minutes',
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
              // if (meta['leaveAt'] != "Leave now")
              // const Text(
              //   '4 RON',
              //   style: TextStyle(
              //       fontFamily: 'UberMove', fontSize: 14, color: Colors.grey),
              // ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Wrap(
                  spacing: 0.0, // Adjust the spacing between elements as needed
                  runSpacing: 5.0, // Adjust the run spacing as needed
                  children: [
                    Row(
                      // Remove this line
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Shorthand(
                          isWalk: false,
                          time: 20,
                          lineName: '21',
                          lineType: "BUS",
                        ),
                        const Icon(Icons.arrow_right_rounded),
                        Shorthand(
                          isWalk: true,
                          time: 20,
                          lineName: '21',
                          lineType: "BUS",
                        ),
                        // ... rest of the elements
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          GestureDetector(
            // onTap: () async {
            //   await callback();

            //   Timer(const Duration(milliseconds: 350), () {
            //     route.changePage('route');
            //     route.changeRouteIndex(index);
            //   });
            // },
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
    );
  }
}
