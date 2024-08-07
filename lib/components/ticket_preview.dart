import 'package:blitz/components/modals/ticket_details_modal.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';

class TicketPreview extends StatefulWidget {
  final bool activeTicket;
  const TicketPreview({required this.activeTicket, super.key});

  @override
  State<TicketPreview> createState() => _TicketPreviewState();
}

class _TicketPreviewState extends State<TicketPreview> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TicketsProvider>(builder: (context, tickets, _) {
      String expiryText = calculateExpiry(tickets.last.expiresAt!);
      return GestureDetector(
        onTap: () async {
          if (widget.activeTicket) {
            TicketDetailsModal.show(context, ScreenBrightness().current);
          }
        },
        child: Container(
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
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.confirmation_num_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tickets.last.name ?? "Not Available",
                          style: const TextStyle(
                              fontFamily: "UberMoveBold", fontSize: 16),
                        ),
                        Text(
                          expiryText,
                          style: const TextStyle(
                              fontFamily: "UberMoveMedium",
                              fontSize: 14,
                              color: darkGrey),
                        ),
                      ],
                    ),
                  ],
                ),
                widget.activeTicket
                    ? const Icon(
                        Icons.arrow_forward_ios,
                        color: darkGrey,
                        size: 18,
                      )
                    : GestureDetector(
                        onTap: () {
                          //Activate the ticket
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "Activeaza",
                                style: TextStyle(
                                    fontFamily: "SFProRounded",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

String calculateExpiry(DateTime expiryDate) {
  final now = DateTime.now();
  final difference = expiryDate.difference(now);

  if (difference.isNegative) {
    return 'Expirat';
  } else if (difference.inDays >= 1) {
    return '${difference.inDays} zile';
  } else if (difference.inHours >= 1) {
    return '${difference.inHours} ore';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} minute';
  } else {
    return 'Mai putin de un minut';
  }
}
