import 'package:blitz/components/modals/tickets_modal.dart';
import 'package:blitz/components/past_transaction_card.dart';
import 'package:blitz/components/payment_methods.dart';
import 'package:blitz/pages/onboarding/onboarding.dart';
import 'package:blitz/pages/successful.dart';
import 'package:blitz/pages/ticket_flow/select_method.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SubtotalModal {
  static void show(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final account = Provider.of<AccountProvider>(context, listen: false);
      final tickets = Provider.of<TicketsProvider>(context, listen: false);

      await tickets.getTickets(account.token);
      await account.getPaymentMethods();
    });
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
        // Schedule the focus request after the bottom sheet is built

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
                      Text(
                        "TOTAL",
                        style:
                            TextStyle(fontFamily: "UberMoveBold", fontSize: 20),
                      ),
                      Text(
                        "RON 5.00",
                        style:
                            TextStyle(fontFamily: "UberMoveBold", fontSize: 20),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
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
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      SelectMethodModal.show(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/ApplePay.png"))),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Apple Pay",
                              style: TextStyle(
                                fontFamily: "UberMoveMedium",
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: darkGrey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Successful(
                                    item: "Abonament zilnic",
                                    amount: 6.00,
                                  )));
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/PayWAP.png"))),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
