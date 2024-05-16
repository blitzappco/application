import 'package:application/components/line_card.dart';
import 'package:application/components/profile_button.dart';
import 'package:application/components/shorthand.dart';
import 'package:application/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(9),
          topRight: Radius.circular(9),
        ),
      ),
      builder: (BuildContext context) {
        // Schedule the focus request after the bottom sheet is built

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              color: Colors.transparent,
              height: 500,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            width: 42,
                            height: 42,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Stanciu Gabriel",
                                style: TextStyle(
                                  fontFamily: "UberMoveBold",
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                "+40735443699",
                                style: TextStyle(
                                  fontFamily: "UberMoveMedium",
                                  color: darkGrey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: lightGrey),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Icon(
                                Icons.close,
                                color: darkGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 32,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ProfileButton(
                          ButtonIcon: Icons.airplane_ticket,
                          ButtonText: "Buy Ticket",
                        ),
                        ProfileButton(
                          ButtonIcon: Icons.settings,
                          ButtonText: "Settings",
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 225, 225, 225),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )),
        );
      },
    );
  }
}
