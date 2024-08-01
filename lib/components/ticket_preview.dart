import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';

class TicketPreview extends StatefulWidget {
  const TicketPreview({super.key});

  @override
  State<TicketPreview> createState() => _TicketPreviewState();
}

class _TicketPreviewState extends State<TicketPreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.confirmation_num_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Abonament saptamanal",
                      style:
                          TextStyle(fontFamily: "UberMoveBold", fontSize: 16),
                    ),
                    Text(
                      "Expira in 3 zile",
                      style: TextStyle(
                          fontFamily: "UberMoveMedium",
                          fontSize: 14,
                          color: darkGrey),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: darkGrey,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
