import 'package:application/models/ticket.dart';
import 'package:flutter/material.dart';

class ActivePass extends StatefulWidget {
  final Ticket ticket;
  const ActivePass({super.key, required this.ticket});

  @override
  State<ActivePass> createState() => _ActivePassState();
}

class _ActivePassState extends State<ActivePass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/card.png'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: 234,
      width: 400,
    );
  }
}
