import 'package:blitz/components/ticket_selection.dart';
import 'package:blitz/components/ticket_selection_compact.dart';
import 'package:blitz/pages/onboarding/onboarding.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatefulWidget {
  @override
  _AddToCartState createState() => _AddToCartState();

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
        return AddToCart();
      },
    );
  }
}

class _AddToCartState extends State<AddToCart> {
  String? selectedTicketType;
  String? selectedDuration;

  void selectTicketType(String type) {
    setState(() {
      selectedTicketType = type;
    });
  }

  void selectDuration(String duration) {
    setState(() {
      selectedDuration = duration;
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
            height: 240,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Abonament Zilnic",
                      style:
                          TextStyle(fontFamily: "UberMoveBold", fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
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
                                size: 18,
                                Icons.close,
                                color: darkGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cantitate",
                          style: TextStyle(
                              fontFamily: "UberMoveMedium",
                              fontSize: 14,
                              color: darkGrey),
                        ),
                        Text(
                          "1",
                          style: TextStyle(
                              fontFamily: "UberMoveMedium", fontSize: 16),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: lightGrey,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: Row(
                          children: [
                            Text(
                              "-",
                              style: TextStyle(
                                  fontFamily: "UberMoveMedium", fontSize: 16),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "|",
                              style: TextStyle(
                                  fontFamily: "UberMoveMedium", fontSize: 16),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "+",
                              style: TextStyle(
                                  fontFamily: "UberMoveMedium", fontSize: 16),
                            )
                          ],
                        ),
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
                        color: const Color.fromARGB(255, 108, 105, 255),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Adauga si vezi cos",
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
                    "Adauga si continua cumparaturilez",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 108, 105, 255),
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
        );
      });
    });
  }
}

class TicketSelection extends StatelessWidget {
  final String Title;
  final String Description;
  final VoidCallback onTap;

  TicketSelection({
    required this.Title,
    required this.Description,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Title,
              style: TextStyle(fontFamily: "UberMoveBold", fontSize: 16),
            ),
            Text(
              Description,
              style: TextStyle(
                  fontFamily: "UberMoveMedium", fontSize: 13, color: darkGrey),
            ),
          ],
        ),
      ),
    );
  }
}
