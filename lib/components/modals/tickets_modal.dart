import 'package:application/components/past_transaction_card.dart';
import 'package:application/utils/vars.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../providers/account_provider.dart';
import '../../providers/tickets_provider.dart';

class TicketsModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9), topRight: Radius.circular(9))),
        builder: (BuildContext context) {
          return Consumer<AccountProvider>(builder: (context, auth, _) {
            return Consumer<TicketsProvider>(builder: (context, tickets, _) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Tickets',
                                style: TextStyle(
                                  fontFamily: "UberMoveBold",
                                  fontSize: 28,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: lightGrey),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.close,
                                  color: darkGrey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.79,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: .3,
                                  blurRadius: 200,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              removeBottom: true,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return PastTransactionCard(
                                      ticket: tickets.list[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.5),
                                    child: Divider(),
                                  );
                                },
                                itemCount: tickets.list.length,
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            });
          });
        });
  }
}
