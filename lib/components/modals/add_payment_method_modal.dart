import 'package:application/components/past_transaction_card.dart';
import 'package:application/components/profile_button.dart';
import 'package:application/components/sheets/add_payment_method_sheet.dart';
import 'package:application/components/shorthand.dart';
import 'package:application/providers/account_provider.dart';
import 'package:application/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethodsModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(9),
          topRight: Radius.circular(9),
        ),
      ),
      builder: (BuildContext context) {
        // Schedule the focus request after the bottom sheet is built

        final AddPaymentMethodSheet sheet = AddPaymentMethodSheet();

        return Consumer<AccountProvider>(builder: (context, account, _) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                color: Colors.transparent,
                height: 500,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Past transactions",
                          style: TextStyle(fontFamily: "UberMoveMedium"),
                        ),
                        Text(
                          "More",
                          style: TextStyle(
                              fontFamily: "UberMoveMedium", color: Colors.blue),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () async {
                                sheet.handle(context);
                              },
                              child: PastTransactionCard()),
                        ],
                      ),
                    )
                  ],
                )),
          );
        });
      },
    );
  }
}
