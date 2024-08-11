import 'package:blitz/pages/ticket_flow/buy_ticket.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyTicketPrompt extends StatefulWidget {
  const BuyTicketPrompt({super.key});

  @override
  State<BuyTicketPrompt> createState() => _BuyTicketPromptState();
}

class _BuyTicketPromptState extends State<BuyTicketPrompt> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TicketsProvider>(builder: (context, tickets, _) {
      return GestureDetector(
        onTap: () {
          tickets.setMustActivate(false);
          BuyTicket.show(context);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                    )),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Achizitioneaza bilete cu Blitz!",
                      style:
                          TextStyle(fontFamily: "UberMoveBold", fontSize: 16),
                    ),
                    Text(
                      "Cumpara de aici",
                      style: TextStyle(
                          fontFamily: "UberMoveMedium",
                          fontSize: 14,
                          color: darkGrey),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
