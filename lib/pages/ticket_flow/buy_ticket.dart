import 'package:blitz/components/ticket_selection.dart' as full;
import 'package:blitz/components/ticket_selection_compact.dart' as compact;
import 'package:blitz/pages/ticket_flow/subtotal_ticket.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/payments.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyTicket extends StatefulWidget {
  const BuyTicket({super.key});

  @override
  State<BuyTicket> createState() => _BuyTicketState();

  static void show(BuildContext context) {
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
        return const BuyTicket();
      },
    );
  }
}

class _BuyTicketState extends State<BuyTicket> {
  String? selectedTicketType;
  String? selectedDuration;
  String? typeID;
  String? name;

  bool subtotalOpen = false;

  void startEditingTicketType() {
    setState(() {
      selectedTicketType = null;
      selectedDuration = null;
    });
  }

  void startEditingDuration() {
    setState(() {
      selectedDuration = null;
    });
  }

  void selectTicketType(String type) {
    setState(() {
      selectedTicketType = type;
      selectedDuration = type == "Bilet" ? "O calatorie" : null;
    });
  }

  void selectDuration(String duration) {
    setState(() {
      selectedDuration = duration;
    });
  }

  Widget buildTicketTypeSelection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5),
          full.TicketSelection(
            Title: "Bilet",
            Description:
                "Valabil pentru o singura calatorie. Biletul va fi afisat timp de 90 de minute.",
            onTap: () {
              selectTicketType("Bilet");
              typeID = "plo-ticket-1";
              name = "Bilet 1 calatorie";
            },
          ),
          const Divider(color: lightGrey),
          full.TicketSelection(
            Title: "Abonament",
            Description:
                "Valabil pentru un numar nelimitat de calatorii pe intreaga durata a abonamentului.",
            onTap: () {
              selectTicketType("Abonament");
            },
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildDurationSelection() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            Text(
              "Durata",
              style: TextStyle(
                fontFamily: "UberMoveMedium",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              full.TicketSelection(
                Title: "Zilnic",
                Description:
                    "Valabil pentru orice mijloc de transport. Biletul va fi afisat timp de 24 de ore de la activare.",
                onTap: () {
                  selectDuration("Zilnic");
                  typeID = "plo-pass-day";
                  name = "Abonament zilnic";
                },
              ),
              const Divider(color: lightGrey),
              full.TicketSelection(
                Title: "Saptamanal",
                Description:
                    "Valabil pentru orice mijloc de transport. Biletul va fi afisat timp de 7 zile de la activare.",
                onTap: () {
                  selectDuration("Saptamanal");
                  typeID = "plo-pass-week";
                  name = "Abonament saptamanal";
                },
              ),
              const Divider(color: lightGrey),
              full.TicketSelection(
                Title: "Lunar",
                Description:
                    "Valabil pentru orice mijloc de transport. Biletul va fi afisat timp de 31 de zile de la activare.",
                onTap: () {
                  selectDuration("Lunar");
                  typeID = "plo-pass-month";
                  name = "Abonament lunar";
                },
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSelectedTicketInfo() {
    return Consumer<AccountProvider>(builder: (context, auth, _) {
      return Consumer<TicketsProvider>(builder: (context, tickets, _) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$selectedTicketType - $selectedDuration",
                  style:
                      const TextStyle(fontFamily: "UberMoveBold", fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Valabil pentru orice mijloc de transport. Biletul va fi afisat in aplicatie pe intreaga durata de valabilitate.",
                  style: TextStyle(
                      fontFamily: "UberMoveMedium",
                      fontSize: 14,
                      color: darkGrey),
                ),
                const SizedBox(height: 10),
                Text(
                  "RON ${getFareText(tickets.ticketTypesMap[typeID ?? '']!.fare ?? 0)}",
                  style: const TextStyle(
                      fontFamily: "UberMoveMedium", fontSize: 16),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () async {
                      // tickets.setTicketID("1234");
                      // print("CREATE PURCHASE: ${tickets.ticketID}");

                      SubtotalTicket.show(context,
                          tickets.ticketTypesMap[typeID ?? '']!.fare ?? 0,
                          () async {
                        await tickets.cancelPurchase(auth.token);
                        await tickets.disposePurchase();
                        // print("DELETE PURCHASE");
                      });

                      // will pre-load the ticket, payment intent
                      // and will attach those two together
                      await tickets.setConfirmed(false);

                      // creating the purchase intent (the ticket)
                      // this function will return
                      // ticketID and fare
                      await tickets.createPurchase(
                          auth.token, typeID ?? '1234', name ?? 'fu');

                      // creating the payment intent (stripe)
                      // this function will return
                      // clientSecret and paymentIntent
                      // and it uses fare
                      await tickets.createPayment(auth.token, auth.selectedPM);

                      // attaching the payment to the purchase
                      // this function uses ticketID and paymentIntent
                      await tickets.attachPurchasePayment(auth.token);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: accentPurple,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Cumpara acum",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "UberMoveBold",
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     subtotalOpen = false;
    //   });
    // });
    return Consumer<TicketsProvider>(
      builder: (context, tickets, _) {
        return Consumer<AccountProvider>(
          builder: (context, auth, _) {
            // WidgetsBinding.instance.addPostFrameCallback((_) async {
            //   print(subtotalOpen);
            //   if (!subtotalOpen) {
            //     // final tickets = Provider.of<TicketsProvider>(context, listen: true);
            //     // final auth = Provider.of<AccountProvider>(context, listen: false);
            //     if (tickets.ticketID != "") {
            //       // await tickets.cancelPurchase(auth.token);
            //       await tickets.disposePurchase();
            //       print("DELETE PURCHASE");
            //     }
            //   }
            // });
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Inchide",
                            style: TextStyle(fontSize: 16, color: accentPurple),
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/tce.png'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                width: 42,
                                height: 42,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TCE Calatori",
                                  style: TextStyle(
                                    fontFamily: "UberMoveBold",
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  "Ploiesti, PH",
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
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (selectedTicketType == null)
                      buildTicketTypeSelection()
                    else
                      GestureDetector(
                        onTap: startEditingTicketType,
                        child: compact.TicketSelectionCompact(
                          Selection: selectedTicketType!,
                          Title: "Tip",
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (selectedTicketType != null &&
                        selectedTicketType != "Bilet")
                      if (selectedDuration == null)
                        buildDurationSelection()
                      else
                        GestureDetector(
                          onTap: startEditingDuration,
                          child: compact.TicketSelectionCompact(
                            Selection: selectedDuration!,
                            Title: "Durata",
                          ),
                        ),
                    const SizedBox(height: 20),
                    if (selectedTicketType != null && selectedDuration != null)
                      buildSelectedTicketInfo(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
