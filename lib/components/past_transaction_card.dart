import 'package:application/models/ticket.dart';
import 'package:application/utils/normalize.dart';
import 'package:application/utils/process_ticket_types.dart';
import 'package:application/utils/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PastTransactionCard extends StatelessWidget {
  final Ticket ticket;
  const PastTransactionCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                processTicketTitle(ticket),
                style: TextStyle(
                  fontFamily: "UberMoveBold",
                  fontSize: 19,
                ),
              ),
              Text(
                "RON ${ticket.fare}",
                style: TextStyle(
                  fontFamily: "UberMoveMedium",
                  fontSize: 19,
                ),
              )
            ],
          ),
          Text(
            "STB Bucuresti",
            style: TextStyle(
                fontFamily: "UberMoveMedium", fontSize: 16, color: darkGrey),
          ),
          Text(
            "${formatDate(ticket.createdAt ?? DateTime.now())}",
            style: TextStyle(
                fontFamily: "UberMoveMedium", fontSize: 16, color: darkGrey),
          )
        ],
      ),
    );
  }
}
