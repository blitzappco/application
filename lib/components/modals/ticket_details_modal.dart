import 'package:blitz/components/past_transaction_card.dart';
import 'package:blitz/utils/vars.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../providers/account_provider.dart';
import '../../providers/tickets_provider.dart';

class TicketDetailsModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9), topRight: Radius.circular(9))),
        builder: (BuildContext context) {
          double screenW = MediaQuery.of(context).size.width;
          return Consumer<AccountProvider>(builder: (context, auth, _) {
            return Consumer<TicketsProvider>(builder: (context, tickets, _) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.close,
                            size: 35,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Center(
                        child: Text(
                          "Abonament Lunar",
                          style: TextStyle(
                              fontFamily: "SFProRounded",
                              fontSize: 32,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
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
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  PrettyQrView.data(
                                      data: 'blitzapp.ro',
                                      decoration: PrettyQrDecoration(
                                          shape: PrettyQrSmoothSymbol(
                                              roundFactor: 0.5))),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    "KHF78h@fg",
                                    style: TextStyle(
                                        fontFamily: "SFProRounded",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: screenW * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: lightGrey),
                        child: const Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Valabilitate",
                              style: TextStyle(
                                fontFamily: "SFProRounded",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "28 zile",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 114, 145, 255),
                                  fontFamily: "SFProRounded",
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  height: 1.1),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(),
                            Text(
                              "Cumparat la: 24 Feb 2024",
                              style: TextStyle(
                                  fontFamily: "SFProRounded",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
          });
        });
  }
}
