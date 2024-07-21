import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

class TicketSelectionCompact extends StatelessWidget {
  final String Title;
  final String Selection;

  TicketSelectionCompact({
    required this.Selection,
    required this.Title,
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
              Title,
              style: TextStyle(fontFamily: "UberMoveMedium", fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  Selection,
                  style: TextStyle(
                    fontFamily: "UberMoveMedium",
                    fontSize: 16,
                    color: darkGrey,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
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
