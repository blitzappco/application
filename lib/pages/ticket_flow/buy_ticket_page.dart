import 'package:blitz/components/modals/add_to_cart.dart';
import 'package:blitz/components/ticket_selection.dart' as full;
import 'package:blitz/components/ticket_selection_compact.dart' as compact;
import 'package:blitz/pages/onboarding/onboarding.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BuyTicketModal extends StatefulWidget {
  @override
  _BuyTicketModalState createState() => _BuyTicketModalState();

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
        return BuyTicketModal();
      },
    );
  }
}

class _BuyTicketModalState extends State<BuyTicketModal> {
  String? selectedTicketType;
  String? selectedDuration;
  bool isEditingTicketType = false;
  bool isEditingDuration = false;

  void selectTicketType(String type) {
    setState(() {
      selectedTicketType = type;
      selectedDuration = null; // Reset duration when ticket type changes
      isEditingTicketType = false;
      isEditingDuration = false;
    });
  }

  void selectDuration(String duration) {
    setState(() {
      selectedDuration = duration;
      isEditingDuration = false;
    });
  }

  void startEditingTicketType() {
    setState(() {
      isEditingTicketType = true;
      isEditingDuration = false;
    });
  }

  void startEditingDuration() {
    setState(() {
      isEditingDuration = true;
      isEditingTicketType = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketsProvider>(builder: (context, tickets, _) {
      return Consumer<AccountProvider>(builder: (context, account, _) {
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
                      child: Text(
                        "Inchide",
                        style: TextStyle(fontSize: 16, color: accentPurple),
                      ),
                    ),
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: accentPurple,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
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
                                builder: (context) => const Onboarding(),
                              ),
                            );
                          },
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
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "TCE Calatori",
                              style: const TextStyle(
                                fontFamily: "UberMoveBold",
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              "Ploiesti, PH",
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
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (isEditingTicketType || selectedTicketType == null)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          full.TicketSelection(
                            Title: "Bilet",
                            Description:
                                "Valabil pentru o singura calatorie. Biletul va fi afisat timp de 30 de minute.",
                            onTap: () => selectTicketType("Bilet"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Divider(
                              color: lightGrey,
                            ),
                          ),
                          full.TicketSelection(
                            Title: "Abonament",
                            Description:
                                "Valabil pentru un numar nelimitat de calatorii pe intreaga durata a abonamentului.",
                            onTap: () => selectTicketType("Abonament"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: startEditingTicketType,
                    child: compact.TicketSelectionCompact(
                      Selection: selectedTicketType!,
                      Title: "Tip",
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (selectedTicketType != null)
                  if (isEditingDuration || selectedDuration == null)
                    Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
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
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                full.TicketSelection(
                                  Title: "Zilnic",
                                  Description:
                                      "Valabil pentru orice mijloc de transport. Biletul va fi afisat timp de 24 de ore de la activare.",
                                  onTap: () => selectDuration("Zilnic"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Divider(
                                    color: lightGrey,
                                  ),
                                ),
                                full.TicketSelection(
                                  Title: "Saptamanal",
                                  Description:
                                      "Valabil pentru orice mijloc de transport. Biletul va fi afisat timp de 7 zile de la activare.",
                                  onTap: () => selectDuration("Saptamanal"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Divider(
                                    color: lightGrey,
                                  ),
                                ),
                                full.TicketSelection(
                                  Title: "Lunar",
                                  Description:
                                      "Valabil pentru orice mijloc de transport. Biletul va fi afisat timp de 31 de zile de la activare.",
                                  onTap: () => selectDuration("Lunar"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    GestureDetector(
                      onTap: startEditingDuration,
                      child: compact.TicketSelectionCompact(
                        Selection: selectedDuration!,
                        Title: "Durata",
                      ),
                    ),
                SizedBox(
                  height: 20,
                ),
                if (selectedTicketType != null && selectedDuration != null)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$selectedTicketType - $selectedDuration",
                                style: TextStyle(
                                    fontFamily: "UberMoveBold", fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Valabil pentru orice mijloc de transport. Biletul va fi afisat in aplicatie pe intreaga durata de valabilitate.",
                                style: TextStyle(
                                  fontFamily: "UberMoveMedium",
                                  fontSize: 14,
                                  color: darkGrey,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "6 RON",
                                style: TextStyle(
                                  fontFamily: "UberMoveMedium",
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: accentPurple,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
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
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              AddToCart.show(context);
                            },
                            child: Text(
                              "Adauga in cos",
                              style: TextStyle(
                                  color: accentPurple,
                                  fontFamily: "UberMoveBold",
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      });
    });
  }
}
