import 'dart:developer';

import 'package:blitz/pages/successful.dart';
import 'package:blitz/pages/ticket_flow/add_card.dart';
import 'package:blitz/pages/ticket_flow/select_method.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/payments.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

class SubtotalTicket {
  static void show(
      BuildContext context, int fare, Future<void> Function() onClose) {
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(9),
          topRight: Radius.circular(9),
        ),
      ),
      builder: (BuildContext context) {
        return Consumer<AccountProvider>(builder: (context, auth, _) {
          return Consumer<TicketsProvider>(builder: (context, tickets, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Container(
                  color: Colors.transparent,
                  height: 240,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "TOTAL",
                            style: TextStyle(
                                fontFamily: "UberMoveBold", fontSize: 20),
                          ),
                          Text(
                            "RON ${getFareText(fare)}",
                            style: const TextStyle(
                                fontFamily: "UberMoveBold", fontSize: 20),
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Metoda de plata",
                            style: TextStyle(
                                fontFamily: "UberMoveMedium",
                                fontSize: 15,
                                color: darkGrey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      auth.account.paymentMethods!.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                SelectMethodModal.show(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(getPMIcon(auth
                                                        .account
                                                        .paymentMethods?[
                                                    auth.selectedPM])))),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        getPMTitle(auth.account
                                            .paymentMethods?[auth.selectedPM]),
                                        style: const TextStyle(
                                          fontFamily: "UberMoveMedium",
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: darkGrey,
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              // the element to add other payment methods
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddCardPage()));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: darkGrey),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: const Icon(
                                          Icons.add,
                                          color: darkGrey,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        "Adauga un card",
                                        style: TextStyle(
                                          fontFamily: "UberMoveMedium",
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: darkGrey,
                                  ),
                                ],
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // this is when the purchase finally goes through
                          inspect(tickets.clientSecret);
                          Stripe.instance
                              .confirmPayment(
                                  paymentIntentClientSecret:
                                      tickets.clientSecret)
                              .then((pi) async {
                            inspect(pi);
                            if (pi.status == PaymentIntentsStatus.Succeeded) {
                              tickets.disposePurchase();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Successful(
                                            item: "Abonament zilnic",
                                            amount: 6.00,
                                          )));
                            } else {
                              inspect(pi);
                            }
                          });
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/PayWAP.png"))),
                        ),
                      ),
                    ],
                  )),
            );
          });
        });
      },
    ).then((void _) {
      onClose();
    });
  }
}
