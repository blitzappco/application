import 'package:application/utils/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PastTransactionCard extends StatelessWidget {
  const PastTransactionCard({super.key});

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
                "Day Pass",
                style: TextStyle(
                  fontFamily: "UberMoveBold",
                  fontSize: 19,
                ),
              ),
              Text(
                "RON 5.99",
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
            "Yesterday",
            style: TextStyle(
                fontFamily: "UberMoveMedium", fontSize: 16, color: darkGrey),
          )
        ],
      ),
    );
  }
}
