import 'package:flutter/material.dart';
import '../../pages/onboarding/phonenumber.dart';
import '../../components/onboarding/socialbuttons.dart';
import '../../utils/vars.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(
                  top: 60,
                  bottom: 50,
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 50,
                )),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: Text(
                'Introdu numărul de telefon',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'UberMoveBold'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PhoneNumber()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(children: [
                      Expanded(
                          child: Text(
                        '+4 ',
                        style: TextStyle(
                            fontSize: 22, fontFamily: 'UberMoveMedium'),
                      ))
                    ]),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: iosGrey,
                      height: 36,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "sau",
                      style: TextStyle(
                          fontSize: 22,
                          color: iosGrey,
                          fontFamily: 'UberMoveMedium'),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: iosGrey,
                      height: 36,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SocialButton(
              buttonText: 'Sign in with Google',
              imageURL:
                  'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png',
            ),
            const SocialButton(
              buttonText: 'Sign in with Apple',
              imageURL:
                  'https://www.freepnglogos.com/uploads/apple-logo-png/apple-logo-png-dallas-shootings-don-add-are-speech-zones-used-4.png',
            ),
            const Column(
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Prin continuare ești de acord cu ',
                    style: TextStyle(fontFamily: 'UberMoveMedium'),
                    children: [
                      TextSpan(
                        text: 'Termenii și condițiile',
                        style: TextStyle(
                          color: Colors.purple,
                          decoration: TextDecoration.underline,
                          fontFamily: 'UberMoveMedium',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'dar și cu ',
                      style: TextStyle(fontFamily: 'UberMoveMedium'),
                      children: [
                        TextSpan(
                          text: 'Politica de confidențialitate.',
                          style: TextStyle(
                            fontFamily: 'UberMoveMedium',
                            color: Colors.purple,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
