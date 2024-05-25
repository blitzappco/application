import 'package:application/components/payment_methods.dart';
import 'package:application/models/tickety_type.dart';
import 'package:application/providers/account_provider.dart';
import 'package:application/providers/tickets_provider.dart';
import 'package:application/utils/process_ticket_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

class BuyPassPage extends StatefulWidget {
  const BuyPassPage({super.key});

  @override
  State<BuyPassPage> createState() => _BuyPassPageState();
}

class _BuyPassPageState extends State<BuyPassPage> {
  String selectedCategory = 'Ticket';
  String selectedTypeID = '1';
  int price = 300;
  String name = 'Ticket for 1 trip';

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, account, _) {
      return Consumer<TicketsProvider>(builder: (context, tickets, _) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 222, 222, 222),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey[600],
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Buy tickets',
                        style: TextStyle(
                            fontFamily: "UberMoveMedium", fontSize: 28),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Select Category',
                        style: TextStyle(
                            fontFamily: "UberMoveMedium", fontSize: 18),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedCategory,
                          items: ['Ticket', 'Pass'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? v) {
                            setState(() {
                              selectedCategory = v!;
                              selectedTypeID =
                                  tickets.typesMap[selectedCategory]?[0].id ??
                                      '0';
                              price =
                                  tickets.typesMap[selectedCategory]?[0].fare ??
                                      0;

                              name = processTypeTitle(
                                  tickets.typesMap[selectedCategory]?[0] ??
                                      TicketType());
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Select Type',
                        style: TextStyle(
                            fontFamily: "UberMoveMedium", fontSize: 18),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedTypeID,
                          items: tickets.typesMap[selectedCategory]!
                              .map((TicketType t) {
                            return DropdownMenuItem<String>(
                                value: t.id, child: Text(processTypeTitle(t)));
                          }).toList(),
                          onChanged: (String? v) {
                            setState(() {
                              selectedTypeID = v!;

                              for (int i = 0;
                                  i <
                                      (tickets.typesMap[selectedCategory]
                                              ?.length ??
                                          0);
                                  i++) {
                                if (tickets.typesMap[selectedCategory]?[i].id ==
                                    selectedTypeID) {
                                  price = tickets.typesMap[selectedCategory]?[i]
                                          .fare ??
                                      0;
                                  name = processTypeTitle(
                                      tickets.typesMap[selectedCategory]?[i] ??
                                          TicketType());
                                }
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(height: 100, child: PaymentMethods())
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${price / 100}",
                            style: const TextStyle(
                                fontFamily: "UberMoveBold", fontSize: 50),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              "RON",
                              style: TextStyle(
                                  fontFamily: "UberMoveMedium", fontSize: 22),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await tickets.setConfirmed(false);
                          // creating the purchase intent
                          await tickets.createPurchaseIntent(
                              account.token, selectedTypeID, name);

                          // creating the payment intent
                          await account.createPaymentIntent(tickets.fare);

                          // attaching the payment to the purchase
                          await tickets.attachPurchasePayment(
                              account.token, account.paymentIntent);

                          // confirm the payment
                          final pi = await Stripe.instance.confirmPayment(
                              paymentIntentClientSecret: account.clientSecret);

                          if (pi.status != PaymentIntentsStatus.Succeeded) {
                            await tickets.setConfirmed(true);
                            await tickets.cancelPurchase();
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 156, 57, 255),
                                borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: tickets.confirmed
                                    ? const SizedBox(
                                        height: 30,
                                        child: Text('Continua',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'UberMoveBold',
                                            )))
                                    : const SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        )),
                              ),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
