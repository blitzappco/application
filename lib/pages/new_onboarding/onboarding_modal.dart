import 'package:blitz/components/modals/tickets_modal.dart';
import 'package:blitz/components/past_transaction_card.dart';
import 'package:blitz/components/payment_methods.dart';
import 'package:blitz/pages/new_onboarding/phone.dart';
import 'package:blitz/pages/onboarding/onboarding.dart';
import 'package:blitz/pages/successful.dart';
import 'package:blitz/pages/ticket_flow/select_method.dart';
import 'package:blitz/providers/account_provider.dart';
import 'package:blitz/providers/tickets_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class OnboardingModal {
  static void show(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final account = Provider.of<AccountProvider>(context, listen: false);
    });
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: lightGrey),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            SvgPicture.asset("assets/images/blitzminimal.svg"),
                      ),
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
                            color: Color.fromARGB(255, 170, 170, 170),
                          ),
                        ),
                      ),
                    ),
                  ],
                ), // Adjust as per your icon
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: "SFProRounded",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome to Blitz, your ultimate transportation co-pilot! Register to effortlessly navigate, buy tickets, and explore local hotspots.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "SFProRounded",
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Handle phone login
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhonePage()),
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Continue with Phone',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "SFProRounded",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: lightGrey),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(
                              'assets/images/applelogo.svg',
                              width: 18,
                              height: 18,
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: lightGrey),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(
                              'assets/images/googlelogo.svg',
                              width: 18,
                              height: 18,
                            ),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'By continuing, you agree to Blitz’s Terms of Use.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
