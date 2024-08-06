import 'package:blitz/pages/new_onboarding/onboarding_modal.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Column(
          children: [],
        ),
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
                  borderRadius: BorderRadius.circular(9),
                  color: const Color.fromARGB(255, 94, 8, 199)),
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
