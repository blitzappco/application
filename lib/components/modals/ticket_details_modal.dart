import 'dart:async';

import 'package:blitz/utils/normalize.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';
import '../../providers/tickets_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:blitz/utils/vars.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class TicketDetailsModal extends StatefulWidget {
  const TicketDetailsModal({super.key});

  @override
  State<TicketDetailsModal> createState() => _TicketDetailsModal();

  static void show(BuildContext context, Future<double> prevBrightness) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(9),
            topRight: Radius.circular(9),
          ),
        ),
        builder: (BuildContext context) {
          return const TicketDetailsModal();
        }).then((_) async {
      // Restore the previous brightness level when the modal is dismissed
      await ScreenBrightness().setScreenBrightness(await prevBrightness);
    });
  }
}

class _TicketDetailsModal extends State<TicketDetailsModal> {
  Timer? _timer;
  String expiry = '';
  DateTime? expiresAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tickets = Provider.of<TicketsProvider>(context, listen: false);
      setState(() {
        expiresAt = tickets.last.expiresAt!;
      });
    });
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(() {
              expiry =
                  calculateExpiry(expiresAt ?? DateTime.now(), DateTime.now());
            }));
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ScreenBrightness().setScreenBrightness(1.0);
    });
    return Consumer<TicketsProvider>(builder: (context, tickets, _) {
      // Calculate expiry

      return Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.close,
                    size: 35,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                tickets.last.name ?? "Not Available",
                style: const TextStyle(
                  fontFamily: "SFProRounded",
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: screenW * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(255, 16, 0, 122),
                    Color.fromARGB(255, 114, 145, 255),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        PrettyQrView.data(
                          data: tickets.last.id ?? 'blitzapp.ro',
                          decoration: const PrettyQrDecoration(
                            shape: PrettyQrSmoothSymbol(
                              roundFactor: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          tickets.last.id ?? "f",
                          style: const TextStyle(
                            fontFamily: "SFProRounded",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: screenW * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: lightGrey,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    "Valabilitate",
                    style: TextStyle(
                      fontFamily: "SFProRounded",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    tickets.expiry != ""
                        ? (tickets.expiry != "exp" ? tickets.expiry : "Expirat")
                        : "Hmmm",
                    style: TextStyle(
                      color: tickets.expiry == "exp"
                          ? Colors.red
                          : const Color.fromARGB(255, 114, 145, 255),
                      fontFamily: "SFProRounded",
                      fontSize: tickets.expiry == '' ? 32 : 32,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  Text(
                    // "Cumparat la: ${DateFormat('dd MMM yyyy').format(tickets.last.createdAt!)}",

                    "Cumparat la: ${DateFormat('dd/mm/yy').format(tickets.last.createdAt!)}",
                    style: const TextStyle(
                      fontFamily: "SFProRounded",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
