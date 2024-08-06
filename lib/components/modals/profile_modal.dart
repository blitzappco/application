import 'package:blitz/components/modals/tickets_modal.dart';
import 'package:blitz/components/past_transaction_card.dart';
import 'package:blitz/components/payment_methods.dart';
import 'package:blitz/pages/onboarding/get_started.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileModal {
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

        return Consumer<TicketsProvider>(builder: (context, tickets, _) {
          return Consumer<AccountProvider>(builder: (context, account, _) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  color: Colors.transparent,
                  height: 550,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  account.logout();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const GetStarted()));
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/moaca.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: BoxShape.circle,
                                      color: Colors.blue),
                                  width: 42,
                                  height: 42,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${account.account.lastName} ${account.account.firstName}",
                                    style: const TextStyle(
                                      fontFamily: "UberMoveBold",
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    account.account.phone ?? '+40712345678',
                                    style: const TextStyle(
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
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment methods",
                            style: TextStyle(fontFamily: "UberMoveMedium"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 120,
                        child: PaymentMethods(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Past transactions",
                            style: TextStyle(fontFamily: "UberMoveMedium"),
                          ),
                          GestureDetector(
                            onTap: () {
                              TicketsModal.show(context);
                            },
                            child: const Text(
                              "More",
                              style: TextStyle(
                                  fontFamily: "UberMoveMedium",
                                  color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: ListView.separated(
                              itemCount: tickets.list.length <= 3
                                  ? tickets.list.length
                                  : 3,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return PastTransactionCard(
                                    ticket: tickets.list[index]);
                              },
                              separatorBuilder: (context, index) {
                                return const Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Divider(
                                    color: lightGrey,
                                  ),
                                );
                              },
                            )),
                      ),
                    ],
                  )),
            );
          });
        });
      },
    );
  }
}
