import 'package:blitz/components/ticket_selection.dart' as full;
import 'package:blitz/components/ticket_selection_compact.dart' as compact;
import 'package:blitz/pages/ticket_flow/ticket_subtotal.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
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
                "Valabil pentru o singura calatorie. Biletul va fi afisat timp de 30 de minute.",
            onTap: () => selectTicketType("Bilet"),
          ),
          const Divider(color: lightGrey),
          full.TicketSelection(
            Title: "Abonament",
            Description:
                "Valabil pentru un numar nelimitat de calatorii pe intreaga durata a abonamentului.",
            onTap: () => selectTicketType("Abonament"),
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
                onTap: () => selectDuration("Zilnic"),
              ),
              const Divider(color: lightGrey),
              full.TicketSelection(
                Title: "Saptamanal",
                Description:
                    "Valabil pentru orice mijloc de transport. Biletul va fi afisat timp de 7 zile de la activare.",
                onTap: () => selectDuration("Saptamanal"),
              ),
              const Divider(color: lightGrey),
              full.TicketSelection(
                Title: "Lunar",
                Description:
                    "Valabil pentru orice mijloc de transport. Biletul va fi afisat timp de 31 de zile de la activare.",
                onTap: () => selectDuration("Lunar"),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSelectedTicketInfo() {
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
              style: const TextStyle(fontFamily: "UberMoveBold", fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              "Valabil pentru orice mijloc de transport. Biletul va fi afisat in aplicatie pe intreaga durata de valabilitate.",
              style: TextStyle(
                  fontFamily: "UberMoveMedium", fontSize: 14, color: darkGrey),
            ),
            const SizedBox(height: 10),
            const Text(
              "6 RON",
              style: TextStyle(fontFamily: "UberMoveMedium", fontSize: 16),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {},
              child: GestureDetector(
                onTap: () {
                  SubtotalModal.show(context);
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketsProvider>(
      builder: (context, tickets, _) {
        return Consumer<AccountProvider>(
          builder: (context, auth, _) {
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