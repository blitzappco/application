import 'dart:async';

import 'package:blitz/components/modals/ticket_details_modal.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:blitz/utils/normalize.dart';

class TicketPreview extends StatefulWidget {
  final bool activeTicket;
  const TicketPreview({required this.activeTicket, super.key});

  @override
  State<TicketPreview> createState() => _TicketPreviewState();
}

class _TicketPreviewState extends State<TicketPreview> {
  Timer? _timer;
  // String expiry = '';
  // DateTime expiresAt = DateTime.now();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final tickets = Provider.of<TicketsProvider>(context, listen: false);
    //   // setState(() {
    //   //   expiresAt = tickets.last.expiresAt!;
    //   // });
    // });
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // void startTimer() {
  //   _timer = Timer.periodic(
  //       const Duration(seconds: 1),
  //       (Timer timer) => setState(() {
  //             expiry = calculateExpiry(expiresAt, DateTime.now());
  //           }));
  // }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final tickets = Provider.of<TicketsProvider>(context, listen: false);
      tickets
          .setExpiry(calculateExpiry(tickets.last.expiresAt!, DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, auth, _) {
      return Consumer<TicketsProvider>(builder: (context, tickets, _) {
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
                            tickets.last.name ?? "Bilet",
                            style: const TextStyle(
                                fontFamily: "UberMoveBold", fontSize: 16),
                          ),
                          Text(
                            tickets.expiry != ""
                                ? (tickets.expiry != "exp"
                                    ? 'Valabil ${tickets.expiry}'
                                    : tickets.last.expiresAt?.year != 1
                                        ? "Expirat"
                                        : "Nevalidat")
                                : "Hmmm",
                            style: const TextStyle(
                                fontFamily: "UberMoveMedium",
                                fontSize: 14,
                                color: darkGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  tickets.last.expiresAt?.year != 1
                      ? const Icon(
                          Icons.arrow_forward_ios,
                          color: darkGrey,
                          size: 18,
                        )
                      : GestureDetector(
                          onTap: () {
                            //Activate the ticket
                            tickets
                                .validateTicket(auth.token, tickets.last.id!)
                                .then((_) {
                              // expiresAt =
                              //     tickets.last.expiresAt ?? DateTime.now();

                              TicketDetailsModal.show(
                                  context, ScreenBrightness().current);
                            });
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
    });
  }
}

/* 
23h 54min
1d 24h

20 de zile

23 de ore si 54 de minute

2d 13h

2 zile 13 ore
1 zi 13 ore
13 ore 25 minute
25 minute
 */


