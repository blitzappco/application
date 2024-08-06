import 'package:blitz/pages/onboarding/onboarding_phone.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingModal {
  static void show(BuildContext context) {
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
            decoration: const BoxDecoration(
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
                      decoration: const BoxDecoration(
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
                const SizedBox(height: 20),
                const Row(
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
                const SizedBox(height: 10),
                const Text(
                  'Welcome to Blitz, your ultimate transportation co-pilot! Register to effortlessly navigate, buy tickets, and explore local hotspots.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "SFProRounded",
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Handle phone login
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnboardingPhone()),
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.black),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
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
                const SizedBox(height: 10),
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
                    const SizedBox(
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
                const SizedBox(height: 20),
                const Text(
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