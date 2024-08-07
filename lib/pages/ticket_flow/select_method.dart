import 'package:blitz/pages/ticket_flow/add_card.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/payments.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectMethodModal {
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

        return Consumer<AccountProvider>(builder: (context, auth, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
                color: Colors.transparent,
                height: 240,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Metode de plata",
                          style: TextStyle(
                              fontFamily: "UberMoveBold", fontSize: 20),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: auth.account.paymentMethods!.length + 1,
                            itemBuilder: (context, index) => (index !=
                                    auth.account.paymentMethods!.length)
                                ? GestureDetector(
                                    onTap: () {
                                      auth.setSelectedPM(index);
                                      Navigator.pop(context);
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
                                                      image: AssetImage(
                                                          getPMIcon(auth.account
                                                                  .paymentMethods?[
                                                              index])))),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              getPMTitle(auth.account
                                                  .paymentMethods?[index]),
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
                                                  border: Border.all(
                                                      color: darkGrey),
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
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
          );
        });
      },
    );
  }
}
