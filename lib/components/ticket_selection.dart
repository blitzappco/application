import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

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
