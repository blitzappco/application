import 'package:blitz/pages/ticket_flow/buy_ticket_page.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

class BuyTicketPrompt extends StatefulWidget {
  const BuyTicketPrompt({super.key});

  @override
  State<BuyTicketPrompt> createState() => _BuyTicketPromptState();
}

class _BuyTicketPromptState extends State<BuyTicketPrompt> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BuyTicketModal.show(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Achizitioneaza bilete cu Blitz!",
                    style: TextStyle(fontFamily: "UberMoveBold", fontSize: 16),
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
  }
}