import 'package:application/models/place.dart';
import 'package:application/utils/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyTrainTicket extends StatefulWidget {
  const BuyTrainTicket({super.key});

  @override
  State<BuyTrainTicket> createState() => _BuyTrainTicketState();
}

class _BuyTrainTicketState extends State<BuyTrainTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                children: [
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
                              Icons.close,
                              color: darkGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
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
