import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

class TicketSelection extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const TicketSelection({
    required this.title,
    required this.description,
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
              title,
              style: const TextStyle(fontFamily: "UberMoveBold", fontSize: 16),
            ),
            Text(
              description,
              style: const TextStyle(
                  fontFamily: "UberMoveMedium", fontSize: 13, color: darkGrey),
            ),
          ],
        ),
      ),
    );
  }
}
