import 'package:application/components/modals/buy_pass.dart';
import 'package:application/utils/vars.dart';
import 'package:flutter/material.dart';

class DisabledPass extends StatefulWidget {
  const DisabledPass({super.key});

  @override
  State<DisabledPass> createState() => _DisabledPassState();
}

class _DisabledPassState extends State<DisabledPass> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BuyPassPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: darkGrey, width: 2),
            borderRadius: BorderRadius.circular(24)),
        height: 234,
        width: 400,
        child: const Center(
          child: Text("Buy transit pass",
              style: TextStyle(
                  fontFamily: "UberMoveMedium", fontSize: 25, color: darkGrey)),
        ),
      ),
    );
  }
}
