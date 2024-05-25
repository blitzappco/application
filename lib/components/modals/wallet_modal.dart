import 'package:application/components/active_train_ticket.dart';
import 'package:application/components/buy_pass.dart';
import 'package:application/components/modals/buy_pass.dart';
import 'package:application/components/passes/active_pass.dart';
import 'package:application/components/passes/disabled_pass.dart';
import 'package:application/components/profile_button.dart';
import 'package:application/components/shorthand.dart';

import 'package:application/pages/train_ticket/buy_train_ticket.dart';
import 'package:application/providers/tickets_provider.dart';
import 'package:application/providers/account_provider.dart';

import 'package:application/utils/animated_text.dart';

import 'package:flutter/cupertino.dart';

import 'package:application/utils/vars.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class WalletModal {
  static void show(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final account = Provider.of<AccountProvider>(context, listen: false);
      final tickets = Provider.of<TicketsProvider>(context, listen: false);
      await tickets.getLastTicket(account.token, "bucuresti");
    });
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
        return Consumer<TicketsProvider>(builder: (context, tickets, _) {
          if (!tickets.confirmed) {
            final account =
                Provider.of<AccountProvider>(context, listen: false);
            tickets.confirmPurchase(account.token);
          }
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
                        child: tickets.show
                            ? ActivePass(ticket: tickets.last)
                            : const DisabledPass()),
                    SizedBox(
                      height: 40,
                    ),
                    if (tickets.show)
                      Image.asset(
                        "assets/images/animation.gif",
                        height: 80,
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    if (tickets.show) AnimatedText()
                  ],
                )),
          );
        });
      },
    );
  }
}
