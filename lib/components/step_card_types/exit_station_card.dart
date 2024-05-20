import 'package:application/utils/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExitStation extends StatelessWidget {
  final String direction;
  const ExitStation({required this.direction, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.logout_rounded, size: 35),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Exit Station",
                    style: TextStyle(fontSize: 18, fontFamily: "UberMoveBold"),
                  ),
                  Text(
                    "To $direction",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "UberMoveMedium",
                        color: darkGrey),
                  ),
                ],
              ),
              Container(
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
                        child: Icon(
                          Icons.navigation_rounded,
                          size: 18,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Navigate",
                        style: TextStyle(fontSize: 14),
                      )
                    ],
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
