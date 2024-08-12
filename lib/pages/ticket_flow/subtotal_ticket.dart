import 'dart:developer';
import 'dart:io';

import 'package:blitz/pages/successful.dart';
import 'package:blitz/pages/ticket_flow/add_card.dart';
import 'package:blitz/pages/ticket_flow/select_method.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/payments.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SubtotalTicket {
  static void show(BuildContext context, int fare, String typeID, String name) {
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
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final tickets = Provider.of<TicketsProvider>(context, listen: false);
          final auth = Provider.of<AccountProvider>(context, listen: false);

          tickets.setBuyLoading(true);

          // will pre-load the ticket, payment intent
          // and will attach those two together
          await tickets.setConfirmed(false);

          // creating the purchase intent (the ticket)
          // this function will return
          // ticketID and fare
          await tickets.createPurchase(auth.token, typeID, name);

          tickets.setBuyLoading(false);
        });
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
                                      SizedBox(
                                        height: 30,
                                        width: 50,
                                        child: SvgPicture.asset(getPMIcon(auth
                                            .account
                                            .paymentMethods?[auth.selectedPM])),
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
                      auth.account.paymentMethods![auth.selectedPM].type ==
                              'card'
                          ? GestureDetector(
                              onTap: () async {
                                tickets.setBuyLoading(true);

                                // creating the payment intent (stripe)
                                // this function will return
                                // clientSecret and paymentIntent
                                // and it uses fare
                                await tickets.createPayment(
                                    auth.token, auth.selectedPM);

                                // attaching the payment to the purchase
                                // this function uses ticketID and paymentIntent
                                await tickets.attachPurchasePayment(auth.token);

                                // and finally,
                                // confirming the payment through stripe
                                Stripe.instance
                                    .confirmPayment(
                                        paymentIntentClientSecret:
                                            tickets.clientSecret)
                                    .then((pi) async {
                                  inspect(pi);
                                  if (pi.status ==
                                      PaymentIntentsStatus.Succeeded) {
                                    String fare = getFareText(tickets.fare);
                                    tickets.movePurchasedToLast();
                                    tickets.setBuyLoading(false);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Successful(
                                                  item: tickets.last.name ??
                                                      "Bilet",
                                                  amount: fare,
                                                )));
                                  } else {
                                    inspect(pi);
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: Colors.black,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      !tickets.buyLoading
                                          ? const Text(
                                              'Continua',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'SFProRounded',
                                              ),
                                            )
                                          : const SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          // : PlatformPayButton(
                          //     onPressed: () {
                          //       print("hey there");
                          //     },
                          //   ),
                          : Expanded(
                              child: PlatformPayButton(
                                onPressed: () async {
                                  tickets.setBuyLoading(true);
                                  print("BUTTON PRESSED");

                                  // creating the payment intent (stripe)
                                  // this function will return
                                  // clientSecret and paymentIntent
                                  // and it uses fare
                                  await tickets
                                      .createPlatformPayment(auth.token);

                                  // attaching the payment to the purchase
                                  // this function uses ticketID and paymentIntent
                                  await tickets
                                      .attachPurchasePayment(auth.token);

                                  // and finally,
                                  // confirming the payment through stripe

                                  if (Platform.isAndroid) {
                                    Stripe.instance
                                        .confirmPlatformPayPaymentIntent(
                                            clientSecret: tickets.clientSecret,
                                            confirmParams:
                                                const PlatformPayConfirmParams
                                                    .googlePay(
                                                    googlePay: GooglePayParams(
                                              currencyCode: "RON",
                                              merchantCountryCode: "RO",
                                              testEnv: true,
                                            )))
                                        .then((pi) async {
                                      inspect(pi);
                                      if (pi.status ==
                                          PaymentIntentsStatus.Succeeded) {
                                        String fare = getFareText(tickets.fare);
                                        tickets.movePurchasedToLast();
                                        tickets.setBuyLoading(false);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Successful(
                                                      item: tickets.last.name ??
                                                          "Bilet",
                                                      amount: fare,
                                                    )));
                                      } else {
                                        inspect(pi);
                                      }
                                    });
                                  }

                                  if (Platform.isIOS) {
                                    Stripe.instance
                                        .confirmPlatformPayPaymentIntent(
                                            clientSecret: tickets.clientSecret,
                                            confirmParams:
                                                const PlatformPayConfirmParams
                                                    .applePay(
                                                    applePay: ApplePayParams(
                                                        currencyCode: "RON",
                                                        merchantCountryCode:
                                                            "RO",
                                                        cartItems: [])))
                                        .then((pi) async {
                                      inspect(pi);
                                      if (pi.status ==
                                          PaymentIntentsStatus.Succeeded) {
                                        String fare = getFareText(tickets.fare);
                                        tickets.movePurchasedToLast();
                                        tickets.setBuyLoading(false);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Successful(
                                                      item: tickets.last.name ??
                                                          "Bilet",
                                                      amount: fare,
                                                    )));
                                      } else {
                                        inspect(pi);
                                      }
                                    });
                                  }
                                },
                                appearance: PlatformButtonStyle.black,
                              ),
                            ),
                    ],
                  )),
            );
          });
        });
      },
    ).then((void _) async {
      final tickets = Provider.of<TicketsProvider>(context, listen: false);
      final auth = Provider.of<AccountProvider>(context, listen: false);

      if (tickets.confirmed == false) {
        await tickets.cancelPurchase(auth.token);
        await tickets.disposePurchase();
      }
    });
  }
}
