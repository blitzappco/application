import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';
import '../../providers/tickets_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:blitz/utils/vars.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class TicketDetailsModal {
  static void show(BuildContext context, Future<double> prevBrightness) {
    // Store the previous brightness level
    // double previousBrightness = await ScreenBrightness().current;

    // Set the brightness to 100%

    // Show the modal
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
        double screenW = MediaQuery.of(context).size.width;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await ScreenBrightness().setScreenBrightness(1.0);
        });
        return Consumer<TicketsProvider>(builder: (context, tickets, _) {
          // Calculate expiry
          String expiryText = calculateExpiry(tickets.last.expiresAt!);

          return Container(
            padding: const EdgeInsets.all(20.0),
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.65,
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
                        expiryText,
                        style: TextStyle(
                          color: expiryText == "Expirat"
                              ? Colors.red
                              : const Color.fromARGB(255, 114, 145, 255),
                          fontFamily: "SFProRounded",
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Divider(),
                      Text(
                        "Cumparat la: ${DateFormat('dd MMM yyyy').format(tickets.last.createdAt!)}",
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
      },
    ).then((_) async {
      // Restore the previous brightness level when the modal is dismissed
      await ScreenBrightness().setScreenBrightness(await prevBrightness);
    });
  }
}

// Expiry calculation function
String calculateExpiry(DateTime expiryDate) {
  final now = DateTime.now();
  final difference = expiryDate.difference(now);

  if (difference.isNegative) {
    return "Expirat";
  } else if (difference.inDays >= 1) {
    return '${difference.inDays} zile';
  } else if (difference.inHours >= 1) {
    return '${difference.inHours} h ${difference.inMinutes % 60} m';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} m ${difference.inSeconds % 60} s';
  } else {
    return '${difference.inSeconds} secunde';
  }
}
