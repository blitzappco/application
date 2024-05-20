import 'package:application/components/active_train_ticket.dart';
import 'package:application/components/profile_button.dart';
import 'package:application/components/shorthand.dart';

import 'package:application/pages/buy_train_ticket.dart';
import 'package:application/utils/env.dart';
import 'package:flutter/cupertino.dart';

import 'package:application/utils/vars.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WalletModal {
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
          padding: const EdgeInsets.all(20.0),
          child: Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Wallet",
                        style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'UberMoveBold',
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: .0),
                    // child: Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.blue,
                    //       borderRadius: BorderRadius.circular(24)),
                    //   height: 234,
                    //   width: 400,
                    // ),
                    //Active pass on top, inactive pass on the bottom
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: darkGrey, width: 2),
                          borderRadius: BorderRadius.circular(24)),
                      height: 234,
                      width: 400,
                      child: Center(
                        child: Text("Buy transit pass",
                            style: TextStyle(
                                fontFamily: "UberMoveMedium", fontSize: 25)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BuyTrainTicket()),
                      );
                    },
                    child: Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "train tickets",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [Text("Active tickets")],
                  ),
                  Divider(
                    color: lightGrey,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ActiveTrainTicket(),
                ],
              )),
        );
      },
    );
  }
}
