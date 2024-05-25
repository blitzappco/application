import 'package:blitz/models/ticket.dart';
import 'package:blitz/utils/normalize.dart';
import 'package:blitz/utils/shorten.dart';
import 'package:blitz/utils/vars.dart';
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
                shorten(ticket.name ?? '', 20),
                style: const TextStyle(
                  fontFamily: "UberMoveBold",
                  fontSize: 19,
                ),
              ),
              Text(
                "RON ${ticket.fare! / 100}",
                style: const TextStyle(
                  fontFamily: "UberMoveMedium",
                  fontSize: 19,
                ),
              )
            ],
          ),
          const Text(
            "STB Bucuresti",
            style: TextStyle(
                fontFamily: "UberMoveMedium", fontSize: 16, color: darkGrey),
          ),
          Text(
            formatDate(ticket.createdAt ?? DateTime.now()),
            style: const TextStyle(
                fontFamily: "UberMoveMedium", fontSize: 16, color: darkGrey),
          )
        ],
      ),
    );
  }
}
