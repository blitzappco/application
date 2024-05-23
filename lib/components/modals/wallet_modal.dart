import 'package:application/components/active_train_ticket.dart';
import 'package:application/components/buy_pass.dart';
import 'package:application/components/modals/buy_pass.dart';
import 'package:application/components/passes/active_pass.dart';
import 'package:application/components/passes/disabled_pass.dart';
import 'package:application/components/profile_button.dart';
import 'package:application/components/shorthand.dart';

import 'package:application/pages/train_ticket/buy_train_ticket.dart';
import 'package:application/utils/animated_text.dart';

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
              height: MediaQuery.of(context).size.height * 0.89,
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onDoubleTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BuyPassPage()));
                        },
                        child: Text(
                          "Wallet",
                          style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'UberMoveBold',
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: .0),
                      child: DisabledPass()),
                  SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    "assets/images/animation.gif",
                    height: 80,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AnimatedText()
                ],
              )),
        );
      },
    );
  }
}
