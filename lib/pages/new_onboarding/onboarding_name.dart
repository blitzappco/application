import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../pages/onboarding/otp.dart';
import '../../providers/account_provider.dart';
import '../../utils/vars.dart';
import '../homescreen.dart';

class OnboardingName extends StatefulWidget {
  const OnboardingName({super.key});

  @override
  State<OnboardingName> createState() => _OnboardingNameState();
}

class _OnboardingNameState extends State<OnboardingName> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstNameController.addListener(_onNameChanged);
    lastNameController.addListener(_onNameChanged);
  }

  @override
  void dispose() {
    firstNameController.removeListener(_onNameChanged);
    firstNameController.dispose();
    lastNameController.removeListener(_onNameChanged);
    lastNameController.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    final auth = Provider.of<AccountProvider>(context, listen: false);
    if (auth.errorMessage.isNotEmpty) {
      auth.setError('');
    }
  }

  Future<void> _continueWithName() async {
    final auth = Provider.of<AccountProvider>(context, listen: false);

    if (lastNameController.text.isEmpty) {
      auth.setError("Nu ai introdus un nume.");
    } else if (firstNameController.text.isEmpty) {
      auth.setError("Nu ai introdus un prenume.");
    } else {
      await auth.addName(firstNameController.text, lastNameController.text);

      if (auth.errorMessage.isEmpty) {
        Timer(const Duration(milliseconds: 200), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Homescreen()),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, auth, _) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OTPPage(),
                            ),
                          );
                        },
                        child: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: lightGrey,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.person_rounded,
                      size: 30,
                      color: darkGrey,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Introdu numele și prenumele",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'SFProRounded',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Hai sa ne cunoastem mai bine!",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'SFProRounded',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Nume",
                  style: TextStyle(
                      fontFamily: "SFProRounded",
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        keyboardType: TextInputType.name,
                        autofillHints: const [AutofillHints.familyName],
                        controller: lastNameController,
                        textInputAction: TextInputAction.done,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'UberMoveMedium',
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color(0xFFE8E8E8),
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  "Prenume",
                  style: TextStyle(
                      fontFamily: "SFProRounded",
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        keyboardType: TextInputType.name,
                        autofillHints: const [AutofillHints.givenName],
                        controller: firstNameController,
                        textInputAction: TextInputAction.done,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color(0xFFE8E8E8),
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          auth.errorMessage,
                          style: const TextStyle(
                            fontSize: 17,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: GestureDetector(
              onTap: _continueWithName,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: const Color(0XFF2E01C8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !auth.loading
                          ? const SizedBox(
                              height: 30,
                              child: Text(
                                'Continua',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SFProRounded',
                                ),
                              ),
                            )
                          : const SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
