import 'package:blitz/pages/onboarding/onboarding_modal.dart';

import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/stock1.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/stock1.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(217, 0, 0, 0),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.58,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      child: Text(
                        "Navighează rapid și inteligent.",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SFProRounded",
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                          height: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: GestureDetector(
            onTap: () {
              OnboardingModal.show(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: blitzPurple),
              child: const Padding(
                padding: EdgeInsets.all(13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Incepe acum",
                      style: TextStyle(
                          fontFamily: "SFProRounded",
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
