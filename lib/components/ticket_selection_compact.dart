import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

class TicketSelectionCompact extends StatelessWidget {
  final String title;
  final String selection;

  const TicketSelectionCompact({
    required this.selection,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style:
                  const TextStyle(fontFamily: "UberMoveMedium", fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  selection,
                  style: const TextStyle(
                    fontFamily: "UberMoveMedium",
                    fontSize: 16,
                    color: darkGrey,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  size: 16,
                  Icons.arrow_forward_ios,
                  color: darkGrey,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
